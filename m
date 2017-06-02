Received: from eggs.gnu.org ([2001:4830:134:3::10]:55487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGpAx-0000Ex-Vg
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGpAu-0006cw-MN
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:11:47 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dGpAu-0006ce-FY
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:11:44 -0400
Received: by mail-wm0-x229.google.com with SMTP id 7so29321544wmo.1
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 09:11:44 -0700 (PDT)
References: <1493314727-6951-1-git-send-email-wei@redhat.com>
	<CAFEAcA-KKvhspYza=8TNNuFtqzco=ChhtS6Aa5hnn8=Cb036-Q@mail.gmail.com>
	<4dbaaea9-7576-9acf-5327-b22db6f00ed2@redhat.com>
	<CAFEAcA8K9DENSPqJD2Okqjqyi7T8RhSBmhCa3ztooJK5xdcZVg@mail.gmail.com>
	<8b782ee5-3545-3cb5-3b09-209fcffee7e4@redhat.com>
	<CAFEAcA8GY3yqZCVHihcFaFS-EkmEy+FRJ9+Kq_xRRdzD7+6DnQ@mail.gmail.com>
	<87k24us83w.fsf@linaro.org>
	<CAFEAcA8OgWtafU+9Jy02VLdfWhdA=LymQrHsR-1SKxGZQFPW0w@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8OgWtafU+9Jy02VLdfWhdA=LymQrHsR-1SKxGZQFPW0w@mail.gmail.com>
Date: Fri, 02 Jun 2017 17:12:02 +0100
Message-ID: <87inkes71p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 2 June 2017 at 16:49, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>> We seem to run into "CONFIG_FOO is defined for make but not
>>> for the C preprocessor" from time to time, so maybe we should
>>> fix that?
>>
>> Hmm is should be auto-generated from config-(host|target).mak but I've
>> never quite figured out why we need timestamps rather than a straight
>> dependency check in rules.mk:
>>
>>   # Generate timestamp files for .h include files
>>
>>   config-%.h: config-%.h-timestamp
>>           @cmp $< $@ >/dev/null 2>&1 || cp $< $@
>>
>>   config-%.h-timestamp: config-%.mak $(SRC_PATH)/scripts/create_config
>>           $(call quiet-command, sh $(SRC_PATH)/scripts/create_config < $< > $@,"GEN","$(TARGET_DIR)config-$*.h")
>>
>> This seems to be one of those things that goes away on a make clean && rebuild
>
> Not the issue in this case -- what happens is that these CONFIG_*
> defines are defined in config-devices.mak, but we don't have any
> equivalent config-devices.h which would expose them to the C code.

Ahh I see. So I guess once the relevant dependencies are added alongside:

  %/config-devices.mak: default-configs/%.mak $(SRC_PATH)/scripts/make_device_config.sh

The default rules should pick it up and generate the right things.

> (I assume the rules.mak stuff is attempting to avoid having a
> not-an-actual-change to the .h file result in rebuilding the whole
> world.)

OK that makes sense.

--
Alex Bennée
