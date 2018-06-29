Received: from eggs.gnu.org ([2001:4830:134:3::10]:38937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYv3T-0006Nt-Ic
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYv3P-0004P6-Hb
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:11:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYv3P-0004OP-CH
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:11:19 -0400
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<CAFEAcA_hfvKR2aRkLO+TL2vAGJecUfNxfXtvtuO94VGMybt1xg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ec389afc-3d16-2cf9-7dd3-2f8f3572d264@redhat.com>
Date: Fri, 29 Jun 2018 10:11:17 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_hfvKR2aRkLO+TL2vAGJecUfNxfXtvtuO94VGMybt1xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/6] audio/hda: create millisecond timers
 that handle IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Martin Schrodt <martin@schrodt.org>, QEMU Developers <qemu-devel@nongnu.org>

On 06/29/2018 03:19 AM, Peter Maydell wrote:
> On 25 June 2018 at 14:12, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> Currently, the HDA device tries to sync itself with the QEMU audio
>> backend by waiting for the guest driver to handle buffer completion
>> interrupts. This causes the backend to often read too much data from the
>> device, as well as running out of data whenever the guest takes too long
>> to handle the interrupt.
>>
>> According to the HDA specification, the guest is also not required to
>> use interrupts, but can also sync itself by polling the LPIB registers.
>>
>> This patch will introduce high frequency (1000Hz) timers that interface
>> with the device and allow for much smoother emulation of the LPIB
>> registers. Since the timing is now provided by these timers, the need
>> to wait for buffer completion interrupts also ceases.
> 
>> +static inline int64_t hda_bytes_per_second(HDAAudioStream *st)
>> +{
>> +    return 2 * st->as.nchannels * st->as.freq;
>> +}
> 
> Hi; Coverity warns about this expression because the
> multiplication is done as a 32-bit multiply and the
> result is returned as a 64-bit (CID 1393631). As usual,
> a suitable cast would fix it.

Said suitable cast might look best written without parentheses, as in:

return 2LL * st->as.nchannels * st->as.freq;

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
