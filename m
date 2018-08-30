Received: from eggs.gnu.org ([2001:4830:134:3::10]:46808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1fvQ5T-0001kP-M6
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1fvQ2d-0007An-42
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:43:31 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:43409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1fvQ2c-0007AQ-Tz
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:43:31 -0400
Received: by mail-io0-x243.google.com with SMTP id y10-v6so8085749ioa.10
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 09:43:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-83-mQAbAvsypXBjFRD9h_St5Sjy+ntAc-jyZ7uDssAg@mail.gmail.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA9hivJzqksiSZbco4+EysYj=_y0t3k_L7TobxNPS8T2dQ@mail.gmail.com>
	<CAHmQWvC4Kp1CAeCe8ZTGtSeG7fnT=Xen4GFKfnhTBWUCJdQV+g@mail.gmail.com>
	<20180829134219.cmyqipnvukk6k2rp@kamzik.brq.redhat.com>
	<CAHmQWvA5t7zbbDDM0UvuKSL_Z8ey+x+vOGZumYjwsq0FC5AHGA@mail.gmail.com>
	<20180830083117.iekobw7l3arkt24m@bivouac.eciton.net>
	<CAFEAcA_s+9-4PYHyx_aAnxwt4e=VH77uBG7rC4JA++nOyjAaPw@mail.gmail.com>
	<20180830100233.nr6fm3npy57zl4xx@bivouac.eciton.net>
	<CAKv+Gu9r+1OBOSUBW_KpDEEoKyc=iwW4zVEe04-_JUnJtSGupQ@mail.gmail.com>
	<CAFEAcA-83-mQAbAvsypXBjFRD9h_St5Sjy+ntAc-jyZ7uDssAg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 30 Aug 2018 18:43:29 +0200
Message-ID: <CAKv+Gu9SLMLrG1fQhF_qFpLWqa4dDn4DrXNqVvNbhi_UnSJTZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Leif Lindholm <leif.lindholm@linaro.org>, Hongbo Zhang <hongbo.zhang@linaro.org>, Andrew Jones <drjones@redhat.com>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 30 August 2018 at 18:36, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 30 August 2018 at 14:29, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> How exactly the firmware figures out how many CPUs and how much memory
>> we are running with is out of scope for this, and so I don't think
>> there is a need to build something from scratch here: DT will do just
>> fine, given that both EDK2 and ARM-TF have working DT code for these
>> things.
>>
>> fw_cfg, on the other hand, is unsuitable for us. Generating ACPI
>> tables in a different way from actual bare metal is not a good idea,
>> given that things like RAS interact with ACPI as well, and fw_cfg is
>> also exposed to the OS in the default mach-virt configuration. So we
>> could tweak fw_cfg to be more suitable, but I think that does not
>> improve the usefulness of our prototype at all.
>
> fw_cfg is an entirely generic transport for passing named
> data blobs from QEMU to the other end. You don't have to
> pass ACPI table fragments over it the way we do for
> virt and the x86 PC platforms if you don't want that.

Sure. But the point is that fw_cfg does not really describe anything
that is useful to us. The information that we need in ARM-TF, and
-directly or indirectly- in UEFI is currently provided via the DT that
is passed in memory, and at the moment, I don't see a reason to change
that since it doesn't conflict with the goals we have for this
prototype. Relying on an emulated device which should never exist on
actual hardware does.

> It's true that it's visible to the OS in the sense that it's
> a physical device in the system, but so is a hardware connection
> to an SCP.
>

Such a connection would not be exposed to the OS on a arm64 server system.
