Received: from eggs.gnu.org ([2001:4830:134:3::10]:45066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lists2009@fnarfbargle.com>) id 1cc6gt-0007hw-Lt
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 03:36:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lists2009@fnarfbargle.com>) id 1cc6gp-0002VG-L1
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 03:36:27 -0500
Received: from ns3.fnarfbargle.com ([43.245.164.105]:38373)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lists2009@fnarfbargle.com>)
	id 1cc6gp-0002Sp-1N
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 03:36:23 -0500
References: <95bdbbb7-e0b7-b932-52a8-93d35b3e1294@gameservers.com>
From: Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <49f9e829-67bb-845e-f343-e04ddfb1ad48@fnarfbargle.com>
Date: Fri, 10 Feb 2017 16:35:00 +0800
MIME-Version: 1.0
In-Reply-To: <95bdbbb7-e0b7-b932-52a8-93d35b3e1294@gameservers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] VirtIO issues after
 83d768b5640946b7da55ce8335509df297e2c7cd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brian Rak <brak@gameservers.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: pbonzini@redhat.com

On 03/02/17 01:14, Brian Rak wrote:
> We recently upgraded to qemu 2.8.0, and noticed a bunch of issues with
> various non-linux operating systems.
>
> I was able to bisect this down to
> 83d768b5640946b7da55ce8335509df297e2c7cd being the commit that breaks
> things (0687c37c5eeef8580b31cc6e1202d874833ae38a which is immediately
> prior still works ok).
>
> The issue here seems to be that guests stop receiving packets, and this
> only happens with vhost_net enabled.
>
>
> I've been consistently able to reproduce this with by booting the
> OpenBSD 5.8 ISO (
> http://mirrors.evowise.com/pub/OpenBSD/5.8/amd64/install58.iso ), and
> pressing 'A' at the first prompt.  It'll attempt to do a DHCP lease, and
> will succeed prior to 83d7.  After that commit, it'll continue to
> transit DHCP requests, but never actually receive the reply.
>
> So far, we've seen this same problem manifest on the following operating
> systems:
>
> * OpenBSD 5.8
> * pfSense 2.2.6 (seems to be FreeBSD 10.1 underneath)
> * Windows XP
> * "9front" (fork of Plan 9)
>
> More modern operating systems did work, including
>
> * Various Linux distributions (CentOS 6+, Ubuntu 12.04+)
> * Modern windows distributions (Server 2012)
> * OpenBSD 6
>
> I was pointed to this thread -
> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg04532.html ,
> and if I apply that patch network connectivity begins working normally
> again. (I am running under x86-64 btw)
>
>

I raised this on the 18th of Jan too. 
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03467.html

I found that it would fail with any linux guest compiled without 
CONFIG_GENERIC_MSI_IRQ.

Thanks for the pointer to the patch. I can apply that and set all the XP 
guests back to virtio networking. (Had to change them to ne2k_pci to get 
networking).

Regards,
Brad
