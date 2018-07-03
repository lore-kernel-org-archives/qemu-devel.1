Received: from eggs.gnu.org ([2001:4830:134:3::10]:34811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faLc2-00059m-3t
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faLby-0005kt-Up
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:44:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60408 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1faLby-0005ka-P8
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:44:54 -0400
References: <20180703101444.23778-1-alex.bennee@linaro.org>
	<20180703101444.23778-12-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8976a555-af38-2998-5b95-5ab294b66520@redhat.com>
Date: Tue, 3 Jul 2018 15:44:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180703101444.23778-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 11/20] docker: filter out linux-user builds
 for mingw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de

On 03/07/2018 12:14, Alex Benn=C3=A9e wrote:
> The recent change from TARGET_DIRS to TARGET_LIST (208ecb3e1) had the
> effect of defaulting all docker builds to the current configured set
> of targets. This is actually reasonable behaviour but does run into
> problems if you have linux-user builds configured and you want to test
> the windows cross builds. This commit fixes that by adding a
> DOCKER_FILTER_TARGETS variable which is special-cased for mingw builds
> so we don't pass the whole set down.

> +# Special cases
> +#  mingw/windows builds cannot build linux-user
> +docker-%-win32-cross: DOCKER_FILTER_TARGETS =3D %-linux-user
> +docker-%-win64-cross: DOCKER_FILTER_TARGETS =3D %-linux-user
> +docker-test-mingw@%: DOCKER_FILTER_TARGETS =3D %-linux-user

Some questions:

1) Any reason to keep all three?

2) Can we do it in the test script instead?

3) DEF_TARGET_LIST in the test script becomes meaningless.

4) You now have to override TARGET_LIST with "make
TARGET_LIST=3Dfoo-softmmu docker-test-mingw@fedora".  Does this interact
badly with other uses of TARGET_LIST in the Makefile?

Thanks,

Paolo
