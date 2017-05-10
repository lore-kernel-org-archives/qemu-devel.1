Received: from eggs.gnu.org ([2001:4830:134:3::10]:47732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1d8X5w-0003dv-9r
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1d8X5t-0007DU-2b
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:16:20 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1d8X5s-0007D8-Ru
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:16:17 -0400
Received: by mail-qk0-x241.google.com with SMTP id y128so753816qka.3
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 12:16:16 -0700 (PDT)
Date: Wed, 10 May 2017 15:16:14 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170510191614.GA8979@morn.lan>
References: <33183CC9F5247A488A2544077AF19020DA2650C5@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA2650C5@DGGEMA505-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [Question] SeaBIOS: cannot boot oracle linux if
 increase the maximum size of permanent high memory area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "seabios@seabios.org" <seabios@seabios.org>, "Xulei (Stone)" <stone.xulei@huawei.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Wulizhen (Pss)" <pss.wulizhen@huawei.com>

On Fri, May 05, 2017 at 10:49:05AM +0000, Gonglei (Arei) wrote:
> Hi guys, 
> 
> Currently my workmate encountered an issues in the testing environment: 
> 
> A letter from him:
> 
> In order to boot a BIG vm (with 4T mem, 255 vCPUs, 60 virtio-scsi
> disk...), i have to increase the BUILD_MAX_HIGHTABLE to 512KB.  But,
> then i found i can not boot a specific VM anymore (oracle linux 6.7
> 64bits with kernel 3.8.13, 2G mem).  It seems be related with the
> unused high ram given VM back by SeaBios (maybe also related to the
> memory align).  I've tested if setting giveback memory 64KB
> alignment other than 4KB, SeaBios with 512KB BUILD_MAX_HIGHTABLE can
> boot the specific VM. But , i don't know the reason...
> 
> As far as i know, if seabios does not give back the unused ZoneHigh
> memory seems will not trigger any problems but just waste only a
> little memory ,right?
> 
> Can you tell me what's the worst effect if i apply the following patch? 
> 
> Does it influence live migration?

The only downside I'm aware of is that it would waste a small amount
of ram.

I'm surprised that "oracle linux" has this issue.  I can only see a
few reasons for it to fail there - a "use after free" bug in seabios,
oracle linux expects the ram to be zero'd, or oracle linux is
expecting the e820 map to have an alignment larger than page size.
The first seems unlikely as "permanent high ram" is rarely ever free'd
in seabios.  The second also seems unlikely.

-Kevin
