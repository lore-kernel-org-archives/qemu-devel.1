Received: from eggs.gnu.org ([2001:4830:134:3::10]:49248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGooq-0001wI-8G
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGool-0001no-B3
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:48:56 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:35080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dGool-0001mn-5D
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:48:51 -0400
Received: by mail-wm0-x233.google.com with SMTP id b84so28898774wmh.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 08:48:49 -0700 (PDT)
References: <1493314727-6951-1-git-send-email-wei@redhat.com>
	<CAFEAcA-KKvhspYza=8TNNuFtqzco=ChhtS6Aa5hnn8=Cb036-Q@mail.gmail.com>
	<4dbaaea9-7576-9acf-5327-b22db6f00ed2@redhat.com>
	<CAFEAcA8K9DENSPqJD2Okqjqyi7T8RhSBmhCa3ztooJK5xdcZVg@mail.gmail.com>
	<8b782ee5-3545-3cb5-3b09-209fcffee7e4@redhat.com>
	<CAFEAcA8GY3yqZCVHihcFaFS-EkmEy+FRJ9+Kq_xRRdzD7+6DnQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8GY3yqZCVHihcFaFS-EkmEy+FRJ9+Kq_xRRdzD7+6DnQ@mail.gmail.com>
Date: Fri, 02 Jun 2017 16:49:07 +0100
Message-ID: <87k24us83w.fsf@linaro.org>
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

> On 28 April 2017 at 14:58, Wei Huang <wei@redhat.com> wrote:
>> Using #ifdef is indeed a cleaner solution. However I can't use "#ifdef
>> CONFIG_ARM_V7M" & co inside target/arm/cpu.c file because CONFIG_xxx
>> aren't available as preprocessor directives. From what I saw the
>> CONFIG_xxx options can only control compiling source file. One solution
>> is to extract out all v7M code into separate files and use
>> CONFIG_ARM_V7M to direct compilation. A bit messy though. Any other
>> suggestions?
>
> We seem to run into "CONFIG_FOO is defined for make but not
> for the C preprocessor" from time to time, so maybe we should
> fix that?

Hmm is should be auto-generated from config-(host|target).mak but I've
never quite figured out why we need timestamps rather than a straight
dependency check in rules.mk:

  # Generate timestamp files for .h include files

  config-%.h: config-%.h-timestamp
          @cmp $< $@ >/dev/null 2>&1 || cp $< $@

  config-%.h-timestamp: config-%.mak $(SRC_PATH)/scripts/create_config
          $(call quiet-command, sh $(SRC_PATH)/scripts/create_config < $< > $@,"GEN","$(TARGET_DIR)config-$*.h")

This seems to be one of those things that goes away on a make clean && rebuild

--
Alex Bennée
