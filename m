Received: from eggs.gnu.org ([2001:4830:134:3::10]:55907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7la2-0003m5-60
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7la1-0000fv-3a
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:09:02 -0400
References: <20181003170228.95973-1-vsementsov@virtuozzo.com>
	<bccd1e94-431f-c7cf-4a0c-599dcf345e73@redhat.com>
	<a6a5cfb4-bfad-a4f5-fb86-e9329da851b6@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e4459a14-298e-1cd7-0805-e7ec30c3fb01@redhat.com>
Date: Wed, 3 Oct 2018 13:08:51 -0500
MIME-Version: 1.0
In-Reply-To: <a6a5cfb4-bfad-a4f5-fb86-e9329da851b6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] nbd server: drop old-style negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "rjones@redhat.com" <rjones@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>

On 10/3/18 12:59 PM, Vladimir Sementsov-Ogievskiy wrote:
> 03.10.2018 20:32, Eric Blake wrote:
> On 10/3/18 12:02 PM, Vladimir Sementsov-Ogievskiy wrote:
> It's unexpected behavior that without -x option qemu-nbd do old-style
> negotiation. Let's use "" as a default name instead (as it is already
> done if tls is used) and therefore, drop old-style negotiation from
> Qemu NBD server.

Hmm, your email quoting style changed from prior emails that used to 
prepend '>' when quoting, making it harder to tell where the text you 
are quoting ends,...

> 
> Oddly enough, I wrote a similar patch in parallel, and am only now just seeing your mail. Yours is a bit stronger than mine (I added 'qemu-nbd -O' to allow explicit fallback to oldstyle, while you ripped it out altogether).  The client can negotiate either style, so we don't need an option on the client side; rather, this is all about what the server should do by default.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00568.html
> 
> Does anyone have a preference between the two? Here's the last time it was discussed:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03252.html
> 

and your reply begins.

> Hm, I think everyone who like new-style should answer that he don't care (except stricter way is a bit better: don't have options and code which we don't need).
> But if there is someone who has client which support only old-style negotiation his unhappiness (in case of strict way) will outweigh all our "bits":)
> 
> I'm from the first group). But let's chose your patch

My argument in favor of your patch over mine: nbdkit is a GREAT testbed 
for forcing all sorts of integration testing scenarios, including 
oldstyle servers.  Also, it includes a plugin for translating between 
new and oldstyle at will.  That is, if we ever legitimately encounter a 
client that can only talk oldstyle, but qemu only talks newstyle, we 
just tell the user to connect:

old client => nbdkit -o nbd => newstyle qemu

and then qemu doesn't have to worry about oldstyle because nbdkit does 
instead.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
