Received: from eggs.gnu.org ([2001:4830:134:3::10]:39539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dUi66-0006ak-Kr
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 19:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dUi65-0004RS-TN
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 19:28:10 -0400
References: <1486979689-230770-1-git-send-email-vsementsov@virtuozzo.com>
	<1486979689-230770-13-git-send-email-vsementsov@virtuozzo.com>
	<20170216130409.GA28784@lemon.lan>
	<d94f4e26-0979-f530-6a88-9ee655843d68@virtuozzo.com>
	<15ffeebf-075d-f540-ac82-0513f367b37b@redhat.com>
	<66e7f481-06f4-2a7e-77fb-1a5c9fc1f301@virtuozzo.com>
	<255b6c77-48e4-217d-f1da-d2544db5b646@redhat.com>
	<53adc05a-03a5-6621-8be1-026003938162@virtuozzo.com>
	<12de589a-5349-b974-3e3b-b2213d84d742@redhat.com>
	<05b4f069-34f5-e35f-9ba1-ee108b685e38@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3222d144-0b65-cb66-c4b9-b3f10dbb2bda@redhat.com>
Date: Mon, 10 Jul 2017 19:27:56 -0400
MIME-Version: 1.0
In-Reply-To: <05b4f069-34f5-e35f-9ba1-ee108b685e38@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/17] migration: add postcopy migration of
 dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, mreitz@redhat.com, dgilbert@redhat.com



On 07/10/2017 05:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> 
> Can we document this somehow?
> 
> In this terminology, what happens with frozen bitmap (which in fact is 
> like "active" for the user) on successful backup finish? It turns into a 
> difference between current-state and what-was-backed-up? It is not very 
> transparent.. May be bitmap part, related to the backup is substituted 
> from the bitmap?
> 
> // it's hard for me to believe that 'frozen' doesn't mean 'can not 
> move', but if it is already established idea then ok.

Admittedly a mistake on my part, mixing up implementation detail and 
exposed interface. It's not necessarily an established idea...

To the end-user, a bitmap that is "frozen" is still indeed recording new 
writes from a certain point of view, because once the backup completes, 
the bitmap (secretly: the promoted successor) will contain writes that 
occurred during that frozen period of time. How could this happen unless 
our "frozen" bitmap was recording writes?

Oops, that's not very frozen at all, is it.

That's an unfortunate bit of design that I didn't take into account when 
I named the "Frozen" property and exposed it via the JSON API. I was 
only thinking about it from the implementation point of view, like you 
are -- the bitmap _is_ well and truly frozen: it cannot be modified and 
does not record any writes. (Only the successor does, as you know.)

So as it stands we have a discrepancy in the code between internal and 
external usage over what exactly "frozen" implies. It's a poor name.

I should have named the QAPI-facing portion of it "locked" or 
"protected" or something that helped imply that it could continue to 
change, but it was off-limits.
