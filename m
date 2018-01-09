Received: from eggs.gnu.org ([2001:4830:134:3::10]:47970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eYwJ2-000213-V0
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eYwJ1-00046G-St
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:59:17 -0500
References: <1513183941-24300-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA8NbL7ROZs99hWhpAF2Rdi2qEiWLNo3hr_9W7gmgXyw4A@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6d20557d-5722-706f-ca4f-489ab85358c0@redhat.com>
Date: Tue, 9 Jan 2018 16:58:56 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8NbL7ROZs99hWhpAF2Rdi2qEiWLNo3hr_9W7gmgXyw4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/2] GICv2 & GICv3: RAZ/WI
 reserved addresses rather than aborting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "patches@linaro.org" <patches@linaro.org>, Drew Jones <drjones@redhat.com>, Auger Eric <eric.auger@redhat.com>, Wei Huang <wei@redhat.com>

On 01/09/18 15:24, Peter Maydell wrote:
> Ping for code review?
> 
> thanks
> -- PMM
> 
> On 13 December 2017 at 16:52, Peter Maydell <peter.maydell@linaro.org> wrote:
>> The GICv2 and GICv3 specifications

here's where I had started running from your patch...

>> say that reserved register
>> addresses should RAZ/WI.

...and I remarked only looking over my shoulder that "RAZ/WI" is not a
verb :)

Sorry, no clue about any of this -- where should I read up?	

Ard did ask a question though:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg500055.html

CC'ing Drew, Eric and Wei. In particular (IIUC) Eric has been looking
into a weird "why do we have so many (and so slow) aborts with GICv4
emulation" issue, at launching UEFI.

Thanks
Laszlo

>> This means we need to return MEMTX_OK, not
>> MEMTX_ERROR, because now that we support generating external aborts
>> the latter will cause an abort on new board models.
>>
>> In particular, at least some versions of UEFI try to
>> access a reserved address in the GICv3 redistributor
>> (at SGI_base + 0x184) and fail to boot on the virt board
>> without this.
>>
>> thanks
>> -- PMM
>>
>> Peter Maydell (2):
>>   hw/intc/arm_gicv3: Make reserved register addresses RAZ/WI
>>   hw/intc/arm_gic: reserved register addresses are RAZ/WI
>>
>>  hw/intc/arm_gic.c              |  5 +++--
>>  hw/intc/arm_gicv3_dist.c       | 13 +++++++++++++
>>  hw/intc/arm_gicv3_its_common.c |  8 +++-----
>>  hw/intc/arm_gicv3_redist.c     | 13 +++++++++++++
>>  4 files changed, 32 insertions(+), 7 deletions(-)
