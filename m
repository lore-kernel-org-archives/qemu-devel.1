Received: from eggs.gnu.org ([2001:4830:134:3::10]:58718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faRFu-0004In-9H
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 15:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faRFr-0000R6-6F
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 15:46:30 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:42621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faRFq-0000PF-Un
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 15:46:27 -0400
Received: by mail-wr0-x22f.google.com with SMTP id p1-v6so3092346wrs.9
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 12:46:26 -0700 (PDT)
References: <20180703101444.23778-1-alex.bennee@linaro.org>
	<20180703101444.23778-12-alex.bennee@linaro.org>
	<8976a555-af38-2998-5b95-5ab294b66520@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8976a555-af38-2998-5b95-5ab294b66520@redhat.com>
Date: Tue, 03 Jul 2018 20:45:23 +0100
Message-ID: <87601w9k8c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 03/07/2018 12:14, Alex Benn=C3=A9e wrote:
>> The recent change from TARGET_DIRS to TARGET_LIST (208ecb3e1) had the
>> effect of defaulting all docker builds to the current configured set
>> of targets. This is actually reasonable behaviour but does run into
>> problems if you have linux-user builds configured and you want to test
>> the windows cross builds. This commit fixes that by adding a
>> DOCKER_FILTER_TARGETS variable which is special-cased for mingw builds
>> so we don't pass the whole set down.
>
>> +# Special cases
>> +#  mingw/windows builds cannot build linux-user
>> +docker-%-win32-cross: DOCKER_FILTER_TARGETS =3D %-linux-user
>> +docker-%-win64-cross: DOCKER_FILTER_TARGETS =3D %-linux-user
>> +docker-test-mingw@%: DOCKER_FILTER_TARGETS =3D %-linux-user
>
> Some questions:
>
> 1) Any reason to keep all three?

We could prune but it doesn't hurt.

>
> 2) Can we do it in the test script instead?
>
> 3) DEF_TARGET_LIST in the test script becomes meaningless.

Good point.

>
> 4) You now have to override TARGET_LIST with "make
> TARGET_LIST=3Dfoo-softmmu docker-test-mingw@fedora".  Does this interact
> badly with other uses of TARGET_LIST in the Makefile?

Yeah I originally thought this made sense from the "docker builds the
same as my configured setup" sense but your right that's overkill.

>
> Thanks,
>
> Paolo


--
Alex Benn=C3=A9e
