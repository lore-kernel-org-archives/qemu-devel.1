Received: from eggs.gnu.org ([2001:4830:134:3::10]:48918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1evQvY-000066-PX
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1evQvW-00070V-0H
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:08:00 -0400
Received: from 8.mo6.mail-out.ovh.net ([178.33.42.204]:42907)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1evQvV-0006zo-Oz
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:07:57 -0400
Received: from player693.ha.ovh.net (unknown [10.109.108.63])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 2DA061477DA
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:07:55 +0100 (CET)
Date: Mon, 12 Mar 2018 18:07:46 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180312180746.43303703@bahia.lan>
In-Reply-To: <9e1dbfe9-e26b-66b6-7009-1c2015160c97@redhat.com>
References: <20180312153344.23453-1-nia.alarie@gmail.com>
	<ad11c22e-294b-d7e3-1589-7c4a42351980@redhat.com>
	<CA+k8WDptLRVNBstB4UEoaorS++_Xqn-j+FHYZhHG1igAJWB-rg@mail.gmail.com>
	<9e1dbfe9-e26b-66b6-7009-1c2015160c97@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] 9p: Convert use of atoi to qemu_strtoi
 to allow error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: nee <nia.alarie@gmail.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>

On Mon, 12 Mar 2018 11:00:39 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 03/12/2018 10:50 AM, nee wrote:
> 
> >>>        } else if (perm & P9_STAT_MODE_LINK) {
> >>> -        int32_t ofid = atoi(extension.data);
> >>> -        V9fsFidState *ofidp = get_fid(pdu, ofid);
> >>> +        int ofid;  
> >>
> >>
> >> 'unsigned int' and...
> >>  
> >>> +        V9fsFidState *ofidp;
> >>> +
> >>> +        if (qemu_strtoi(extension.data, NULL, 10, &ofid)) {  
> >>
> >>
> >> qemu_strtoui() might be smarter, per Greg's comments on v1.
> >>  
> >>> +            err = -EINVAL;
> >>> +            goto out;
> >>> +        }
> >>> +        ofidp = get_fid(pdu, (int32_t)ofid);  
> >>
> >>
> >> This cast is spurious.
> >>
> >> --
> >> Eric Blake, Principal Software Engineer
> >> Red Hat, Inc.           +1-919-301-3266
> >> Virtualization:  qemu.org | libvirt.org  
> > 
> > I did this because get_fid() takes an int32_t, not an unsigned int.
> > The struct V9fsFidState also uses an int32_t for its `fid` member. Do
> > you want me to change all these types, or just the function being used
> > here?  
> 
> I'll let Greg answer; he's more familiar with the 9p code (I was just 
> commenting based on his initial answer to v1).
> 

Yeah... as I was saying, fids are 32-bit unsigned per spec but the code is
using int32_t indeed. This is incorrect and it should be fixed.
