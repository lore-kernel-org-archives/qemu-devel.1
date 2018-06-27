Received: from eggs.gnu.org ([2001:4830:134:3::10]:37772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fY3pE-00042y-1T
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fY3pD-0007LX-04
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:21:08 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:51035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <loseweigh@gmail.com>) id 1fY3pC-0007KL-K6
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:21:06 -0400
Received: by mail-it0-x242.google.com with SMTP id u4-v6so5847263itg.0
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 23:21:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627032825-mutt-send-email-mst@kernel.org>
References: <CADGSJ23SBEFJCD50K-F-Gt86Q1-i_6iHTmSSjdXDzNnnpWZ_oQ@mail.gmail.com>
	<CADGSJ22nLcz_XaJNzUUdpjQaJY8b5wZs=ohm=B7c2qf2K7_yGA@mail.gmail.com>
	<20180623002628-mutt-send-email-mst@kernel.org>
	<CADGSJ20td7b6He6S1PBSJjCq=bNvgqMGbOjiho2eeQm2pgpK3g@mail.gmail.com>
	<20180623012406-mutt-send-email-mst@kernel.org>
	<CADGSJ211pWKYnuuzcgUqJZiHU+=7H3oQSpp1TnE=+EBjkdmCSQ@mail.gmail.com>
	<CADGSJ22DX8=rNPY+gNS_q=LCYLR5ieoE7oD8p4+8AnpzQsWSCg@mail.gmail.com>
	<da144f8f-65cd-45d9-3c81-6c8ca1fb25fe@intel.com>
	<20180626044650-mutt-send-email-mst@kernel.org>
	<CADGSJ204fgdnafRsrzMVh+SeBCj3-z_twS9B+7g8iiOaUQGW5g@mail.gmail.com>
	<20180627032825-mutt-send-email-mst@kernel.org>
From: Siwei Liu <loseweigh@gmail.com>
Date: Tue, 26 Jun 2018 23:21:04 -0700
Message-ID: <CADGSJ22Sv_AFUkDou6hdq9++RNC40BTB-puS9209tOqzGLFJ-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com

On Tue, Jun 26, 2018 at 5:29 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Jun 26, 2018 at 04:38:26PM -0700, Siwei Liu wrote:
>> On Mon, Jun 25, 2018 at 6:50 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Mon, Jun 25, 2018 at 10:54:09AM -0700, Samudrala, Sridhar wrote:
>> >> > > > > Might not neccessarily be something wrong, but it's very limited to
>> >> > > > > prohibit the MAC of VF from changing when enslaved by failover.
>> >> > > > You mean guest changing MAC? I'm not sure why we prohibit that.
>> >> > > I think Sridhar and Jiri might be better person to answer it. My
>> >> > > impression was that sync'ing the MAC address change between all 3
>> >> > > devices is challenging, as the failover driver uses MAC address to
>> >> > > match net_device internally.
>> >>
>> >> Yes. The MAC address is assigned by the hypervisor and it needs to manage the movement
>> >> of the MAC between the PF and VF.  Allowing the guest to change the MAC will require
>> >> synchronization between the hypervisor and the PF/VF drivers. Most of the VF drivers
>> >> don't allow changing guest MAC unless it is a trusted VF.
>> >
>> > OK but it's a policy thing. Maybe it's a trusted VF. Who knows?
>> > For example I can see host just
>> > failing VIRTIO_NET_CTRL_MAC_ADDR_SET if it wants to block it.
>> > I'm not sure why VIRTIO_NET_F_STANDBY has to block it in the guest.
>>
>> That's why I think pairing using MAC is fragile IMHO. When VF's MAC
>> got changed before virtio attempts to match and pair the device, it
>> ends up with no pairing found out at all.
>
> Guest seems to match on the hardware mac and ignore whatever
> is set by user. Makes sense to me and should not be fragile.
Host can change the hardware mac for VF any time.

-Siwei
>
>
>> UUID is better.
>>
>> -Siwei
>>
>> >
>> > --
>> > MST
