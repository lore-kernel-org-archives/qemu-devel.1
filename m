Received: from eggs.gnu.org ([2001:4830:134:3::10]:60237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fikwb-0001Vd-I0
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 14:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fikwa-0003ka-Aw
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 14:24:57 -0400
References: <20180726113337.23144-1-kwolf@redhat.com>
	<605ad10a-13c0-7f62-1c71-a8afe9021ee6@redhat.com>
	<20180726150655.GG4215@localhost.localdomain>
	<6cdde651-acdc-e6eb-63fc-e7efe8136710@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1d5a5355-344e-7029-f7d7-ddb52c65651a@redhat.com>
Date: Thu, 26 Jul 2018 13:24:49 -0500
MIME-Version: 1.0
In-Reply-To: <6cdde651-acdc-e6eb-63fc-e7efe8136710@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] file-posix: Fix write_zeroes with
 unmap on block devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: famz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, Nir Soffer <nsoffer@redhat.com>, pbonzini@redhat.com

On 07/26/2018 10:23 AM, Eric Blake wrote:

> 
> Hmm - that thread also mentions FALLOC_FL_NO_HIDE_STALE, which is a new 
> flag not present/documented on Fedora 28. I wonder if it helps, too.

Even more odd - that flag has been proposed to the kernel since 2012 but 
still not mentioned in the F28 man page:

https://lwn.net/Articles/492920/

and that its use on block devices is much more recent, just last month:

https://webcache.googleusercontent.com/search?q=cache:1LV2Y06XnjkJ:https://patchwork.kernel.org/patch/10466183/+&cd=5&hl=en&ct=clnk&gl=us&client=firefox-b-1

but now that I've read that, it makes total sense that the combination 
PUNCH_HOLE|NO_HIDE_STALE is explicitly asking for semantics of "discard 
as fast as possible regardless of whatever later reads will see", while 
plain PUNCH_HOLE means "guarantee that I can read zeroes, using the 
fastest means possible [discard, if that works]"

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
