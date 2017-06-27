Received: from eggs.gnu.org ([2001:4830:134:3::10]:53426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPg4X-0008M9-Rl
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPg4T-0001ke-SU
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:17:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dPg4T-0001jy-JJ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:17:41 -0400
Date: Mon, 26 Jun 2017 23:17:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170627021734.GS12152@localhost.localdomain>
References: <20170625192950.17677-1-f4bug@amsat.org>
	<20170625192950.17677-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170625192950.17677-4-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] coccinelle: script to run them all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On Sun, Jun 25, 2017 at 04:29:49PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  scripts/check-cocci-scripts.sh | 47 ++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100755 scripts/check-cocci-scripts.sh
>=20
> diff --git a/scripts/check-cocci-scripts.sh b/scripts/check-cocci-scrip=
ts.sh
> new file mode 100755
> index 0000000000..ec3a8b39ef
> --- /dev/null
> +++ b/scripts/check-cocci-scripts.sh
> @@ -0,0 +1,47 @@
> +#! /usr/bin/env bash
> +
> +test -d scripts/coccinelle || exit 1
> +
> +SPATCH_IMAGE=3D"philmd/coccinelle:1.0.4"
> +
> +GIT_AUTHOR_NAME=3D"Coccinelle Spatch"
> +GIT_COMMITTER_NAME=3D"Coccinelle Spatch"
> +
> +if [ -n "$TRAVIS" ]; then
> +	# avoid stalling builds: https://docs.travis-ci.com/user/common-build=
-problems/#Build-times-out-because-no-output-was-received
> +	TIMEOUT_S=3D530
> +	TIMEOUT_CMD=3D"timeout -k 550 500"
> +	EXTRA_ARGS=3D"--timeout ${TIMEOUT_S}"
> +else
> +	TIMEOUT_S=3D0
> +fi
> +
> +HEAD=3D19 #`echo -n scripts/coccinelle/ | wc -c`
> +TAIL=3D6 #`echo -n .cocci | wc -c`
> +
> +test -z "$(${SUDO} docker images -q ${SPATCH_IMAGE})" && ${SUDO} docke=
r pull ${SPATCH_IMAGE}
> +

Can the docker magic be made optional (and disabled by default), so
people who already have Coccinelle installed can run this script more
quickly?


> +LOG=3D/tmp/cocci-spatch-$$
> +for script in scripts/coccinelle/*.cocci; do
> +	desc=3D${script:$HEAD:-$TAIL}
> +	echo -e "\nRunning ${script}...\n"
> +	echo -e "coccinelle: committing changes after running \"$desc\" scrip=
t\n" > ${LOG}.topic
> +	${TIMEOUT_CMD} ${SUDO} \
> +	docker run --rm -v `pwd`:`pwd` -w `pwd` -u `id -u` \
> +		${SPATCH_IMAGE} --use-cache --use-gitgrep --keep-comments \
> +			--very-quiet ${EXTRA_ARGS} \
> +			--sp-file ${script} \
> +			--macro-file scripts/cocci-macro-file.h \
> +			--dir . \
> +			--in-place | tee ${LOG}.content
> +	git add -u
> +	git diff --cached --exit-code -s
> +	if [ $? -ne 0 ]; then
> +		:> ${LOG}.content
> +	else
> +		test -s ${LOG}.content || continue
> +	fi
> +	cat ${LOG}.{topic,content} | git commit --allow-empty -F -
> +done
> +
> +rm -f ${LOG}.{topic,content}
> --=20
> 2.13.1
>=20

--=20
Eduardo
