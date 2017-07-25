Received: from eggs.gnu.org ([2001:4830:134:3::10]:45884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZwT0-0000OX-El
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZwSx-0007ff-9E
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:49:26 -0400
References: <20170725061158.10745-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <865f533b-8fe7-dd3d-be79-c2852ef0508d@redhat.com>
Date: Tue, 25 Jul 2017 11:49:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170725061158.10745-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Makefile: add
 all-user/all-linux-user/all-softmmu meta-targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On 25/07/2017 08:11, Philippe Mathieu-Daud=C3=A9 wrote:
> Useful to build a whole set at once.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  Makefile | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index 5f18243d05..da899522e4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -814,6 +814,11 @@ endif
>  # Dependencies in Makefile.objs files come from our recursive subdir r=
ules
>  -include $(wildcard *.d tests/*.d)
> =20
> +.PHONY: subdir-all-user subdir-all-linux-user subdir-all-softmmu
> +subdir-all-user: $(patsubst %,subdir-%,$(filter %-user,$(TARGET_DIRS))=
)
> +subdir-all-linux-user: $(patsubst %,subdir-%,$(filter %-linux-user,$(T=
ARGET_DIRS)))
> +subdir-all-softmmu: $(patsubst %,subdir-%,$(filter %-softmmu,$(TARGET_=
DIRS)))

I'm not sure why you need subdir-all-linux-user.  I think it's okay to
add these, but please add "romsubdir-all" too.  This way "all" can use
"subdir-all-user subdir-all-softmmu romsubdir-all" and you can remove
"recurse-all".

Paolo

>  include $(SRC_PATH)/tests/docker/Makefile.include
> =20
>  .PHONY: help
> @@ -827,7 +832,7 @@ help:
>  	@echo  ''
>  	@$(if $(TARGET_DIRS), \
>  		echo 'Architecture specific targets:'; \
> -		$(foreach t, $(TARGET_DIRS), \
> +		$(foreach t, $(TARGET_DIRS) all-user all-linux-user all-softmmu, \
>  		printf "  %-30s - Build for %s\\n" $(patsubst %,subdir-%,$(t)) $(t);=
) \
>  		echo '')
>  	@echo  'Cleaning targets:'
>=20
