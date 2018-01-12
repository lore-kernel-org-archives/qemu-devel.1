Received: from eggs.gnu.org ([2001:4830:134:3::10]:55766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZyAF-0000KI-Sa
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZyAA-00081X-1M
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:10:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZyA9-00080g-PM
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:10:21 -0500
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
	<20180111082738.27295.80055.stgit@pasha-VirtualBox>
	<0e223aaa-c3c9-1cdf-5548-5a532d3a7361@redhat.com>
	<000901d38add$ddb4b750$991e25f0$@ru>
	<17a6b61c-e151-a5e1-978a-b54da71dbe55@redhat.com>
	<001301d38b6c$83c6d090$8b5471b0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1fa94259-35a3-01ce-ebbb-94163508e5a8@redhat.com>
Date: Fri, 12 Jan 2018 13:10:03 +0100
MIME-Version: 1.0
In-Reply-To: <001301d38b6c$83c6d090$8b5471b0$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 29/30] replay: improve replay
 performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 12/01/2018 07:13, Pavel Dovgalyuk wrote:
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> On 11/01/2018 14:12, Pavel Dovgalyuk wrote:
>>>> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo Bonzini
>>>> On 11/01/2018 09:27, Pavel Dovgalyuk wrote:
>>>>> +        } else {
>>>>> +            qemu_notify_event();
>>>>> +        }
>>>>
>>>> Before this patch, what would do the qemu_notify_event?
>>>
>>> We tried using qemu_notify_event to wake up the iothread and speedup the replay,
>>> when there is no work for vcpu thread to do.
>>
>> But why doesn't the iothread wake up on its own?
> 
> It will wake up by timeout. But with this change this happens sooner and replay goes faster.

If you want replays to ignore timeouts, that should be done by ensuring
that qemu-timer.c passes a zero timeout to main-loop.c.  (It probably
should be optional, too, maybe via -icount sleep).

Paolo
