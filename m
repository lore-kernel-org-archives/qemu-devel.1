Received: from eggs.gnu.org ([2001:4830:134:3::10]:50433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGovm-0004AY-8M
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGovl-0005Wf-08
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:56:06 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGovk-0005WO-Hn
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:56:04 -0400
Received: by mail-wr0-x22f.google.com with SMTP id v104so9179224wrb.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 08:56:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87k24us83w.fsf@linaro.org>
References: <1493314727-6951-1-git-send-email-wei@redhat.com>
	<CAFEAcA-KKvhspYza=8TNNuFtqzco=ChhtS6Aa5hnn8=Cb036-Q@mail.gmail.com>
	<4dbaaea9-7576-9acf-5327-b22db6f00ed2@redhat.com>
	<CAFEAcA8K9DENSPqJD2Okqjqyi7T8RhSBmhCa3ztooJK5xdcZVg@mail.gmail.com>
	<8b782ee5-3545-3cb5-3b09-209fcffee7e4@redhat.com>
	<CAFEAcA8GY3yqZCVHihcFaFS-EkmEy+FRJ9+Kq_xRRdzD7+6DnQ@mail.gmail.com>
	<87k24us83w.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2017 16:55:42 +0100
Message-ID: <CAFEAcA8OgWtafU+9Jy02VLdfWhdA=LymQrHsR-1SKxGZQFPW0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix compilation dependency issues of
 CONFIG_ARM_V7M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Wei Huang <wei@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2 June 2017 at 16:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> We seem to run into "CONFIG_FOO is defined for make but not
>> for the C preprocessor" from time to time, so maybe we should
>> fix that?
>
> Hmm is should be auto-generated from config-(host|target).mak but I've
> never quite figured out why we need timestamps rather than a straight
> dependency check in rules.mk:
>
>   # Generate timestamp files for .h include files
>
>   config-%.h: config-%.h-timestamp
>           @cmp $< $@ >/dev/null 2>&1 || cp $< $@
>
>   config-%.h-timestamp: config-%.mak $(SRC_PATH)/scripts/create_config
>           $(call quiet-command, sh $(SRC_PATH)/scripts/create_config < $<=
 > $@,"GEN","$(TARGET_DIR)config-$*.h")
>
> This seems to be one of those things that goes away on a make clean && re=
build

Not the issue in this case -- what happens is that these CONFIG_*
defines are defined in config-devices.mak, but we don't have any
equivalent config-devices.h which would expose them to the C code.

(I assume the rules.mak stuff is attempting to avoid having a
not-an-actual-change to the .h file result in rebuilding the whole
world.)

thanks
-- PMM
