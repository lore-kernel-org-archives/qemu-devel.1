Received: from eggs.gnu.org ([2001:4830:134:3::10]:52470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eh4Su-0003t2-QJ
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eh4Sq-0001FH-Qy
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:19:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eh4Sq-0001El-KM
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:19:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD5D7C0587C9
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 02:18:59 +0000 (UTC)
Date: Thu, 1 Feb 2018 10:18:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180201021853.GD31397@xz-mi>
References: <20180131092835.GA31397@xz-mi>
	<20180131160214-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180131160214-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] Windows balloon driver PFN issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Wed, Jan 31, 2018 at 04:03:12PM +0200, Michael S. Tsirkin wrote:
> On Wed, Jan 31, 2018 at 05:28:35PM +0800, Peter Xu wrote:
> > Hi, Michael and the list,
> > 
> > I observed this on windows 8 enterprise guests, when doing memory ballooning:
> > 
> > 23892@1517298572.328354:virtio_balloon_to_target balloon target: 0x80000000 num_pages: 524288
> > 23892@1517298638.542819:virtio_balloon_get_config num_pages: 524288 actual: 0
> > 23892@1517298638.542974:virtio_balloon_handle_output section name: pc.ram gpa: 0x174604000
> > 23892@1517298638.543059:virtio_balloon_handle_output section name: pc.ram gpa: 0x0
> > 23892@1517298638.543135:virtio_balloon_handle_output section name: pc.ram gpa: 0x17460a000
> > 23892@1517298638.543140:virtio_balloon_handle_output section name: pc.ram gpa: 0x0
> > 23892@1517298638.543143:virtio_balloon_handle_output section name: pc.ram gpa: 0x17460b000
> > 23892@1517298638.543146:virtio_balloon_handle_output section name: pc.ram gpa: 0x0
> > 23892@1517298638.543148:virtio_balloon_handle_output section name: pc.ram gpa: 0x17460c000
> > 23892@1517298638.543152:virtio_balloon_handle_output section name: pc.ram gpa: 0x0
> > 23892@1517298638.543154:virtio_balloon_handle_output section name: pc.ram gpa: 0x17460d000
> > 23892@1517298638.543159:virtio_balloon_handle_output section name: pc.ram gpa: 0x0
> > 23892@1517298638.543162:virtio_balloon_handle_output section name: pc.ram gpa: 0x17460e000
> > 23892@1517298638.543165:virtio_balloon_handle_output section name: pc.ram gpa: 0x0
> > 23892@1517298638.543167:virtio_balloon_handle_output section name: pc.ram gpa: 0x17460f000
> > 23892@1517298638.543170:virtio_balloon_handle_output section name: pc.ram gpa: 0x0
> > ...
> > 
> > I think it's very possible that these zero addresses (please let me
> > know what the first 4K page is used for if anyone knows, since IIUC
> > that's what we throw away now) are half of the 64bit PFN.  Or say, not
> > sure whether this means a windows guest driver bug that is using
> > 64bits for PFN rather than 32bits (and I suppose the protocol is using
> > 32bit for PFNs).
> > 
> > Michael, do you know what to do with this?
> > 
> > Thanks,
> 
> PFN is GPA>>12.  Do you have more than 1<<44 bytes of memory in this VM then?

No.  But isn't it still not good to drop the page at offset zero (and
drop it NNN times)?  And I'm not sure what will happen if guest has
1<<44 bytes; then we'll possibly drop very random addresses since a
real address will be splitted?

Thanks,

-- 
Peter Xu
