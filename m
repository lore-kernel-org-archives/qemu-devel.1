Received: from eggs.gnu.org ([2001:4830:134:3::10]:49249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e4ROO-0006pq-7y
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e4ROK-00024S-3V
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:54:43 -0400
References: <1506524205-20763-1-git-send-email-eric.auger@redhat.com>
	<1506524205-20763-2-git-send-email-eric.auger@redhat.com>
	<CAFEAcA9P51hn60vYErotTBc9m4REq=fgfp0ZN18mFtoLLbS9ZQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f2e21f58-f630-cbf4-904a-3d86d7c38d3f@redhat.com>
Date: Tue, 17 Oct 2017 14:54:20 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9P51hn60vYErotTBc9m4REq=fgfp0ZN18mFtoLLbS9ZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/3] hw/intc/arm_gicv3_its: Don't abort on
 table save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wanghaibin.wang@huawei.com, Vijay Kilari <vijay.kilari@gmail.com>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, wu.wubin@huawei.com

Hi Peter,
On 12/10/2017 13:54, Peter Maydell wrote:
> On 27 September 2017 at 15:56, Eric Auger <eric.auger@redhat.com> wrote:
>> The ITS is not properly reset at the moment. It is possible the
>> GITS_BASER<n>.valid is set and the in-kernel ITS caches are not
>> empty (list of devices, collections, LPIs) while data structures
>> in guest RAM are invalid/inconsistent.
>>
>> For instance, this happens after a guest shutdown -r now or a
>> system reset, if we save the state before the guest re-writes
>> the ITS registers or map devices, the table save ioctl may
>> produce a QEMU abort.
>>
>> Until there is a proper reset implemented, let's unplug the
>> consistency error checking.
>>
>> The reset issue will be fixed in subsequent patches.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reported-by: wanghaibin <wanghaibin.wang@huawei.com>
> 
> When in particular does this cause an abort -- when we're
> trying to save the state in these edge cases, or when we're
> trying to restore it?
Both.

After a guest reset, device GITS_BASER<n> may point to an L1 device
table that is not valid anymore. In that case device table save IOTCL
returned -EINVAL and we aborted.

On restore we had a bug in case all data in the table is invalid. In
that case as well we currently abort.

 What does the kernel do -- is it just
> rejecting the attempt, or might it actually have done bad
> things to guest memory ?
On Save, in case the GITS_BASER points to an invalid linear device tree
table but the page still corresponds to a visible gfn window, this
memory could be overwritten by the kernel.

Thanks

Eric
> 
> thanks
> -- PMM
> 
