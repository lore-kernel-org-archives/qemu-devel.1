Received: from eggs.gnu.org ([2001:4830:134:3::10]:37039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxa4N-00081d-CW
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxa4M-00085u-Ju
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:50:15 -0400
References: <20180904170930.28619-1-jsnow@redhat.com>
	<20180904170930.28619-7-jsnow@redhat.com>
	<cd9e2b78-9aa1-b988-fe15-b7f59f8bd5d1@redhat.com>
	<a84c5441-a2be-e680-2b78-a9c0251d0aa7@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cbfcc66b-f8e3-7677-909e-e71024da5c5f@redhat.com>
Date: Wed, 5 Sep 2018 10:50:03 -0500
MIME-Version: 1.0
In-Reply-To: <a84c5441-a2be-e680-2b78-a9c0251d0aa7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 06/15] block/mirror: conservative
 mirror_exit refactor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com

On 09/05/2018 08:09 AM, John Snow wrote:
> 
> 
> On 09/05/2018 06:43 AM, Max Reitz wrote:
>> On 2018-09-04 19:09, John Snow wrote:
>>> For purposes of minimum code movement, refactor the mirror_exit
>>> callback to use the post-finalization callbacks in a trivial way.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>   block/mirror.c | 34 +++++++++++++++++++++++++++-------
>>>   1 file changed, 27 insertions(+), 7 deletions(-)
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>> (Although I believe the ?: hunk from the previous patch should be here.
>> Also note that we have a couple of places that make use of the GNU
>> extension for "?:" as a binary operator (as in "x ?: y" returns x if
>> x != 0).  Just in case you find "s->to_replace ?: src" as appealing as I
>> do.)
>>
> 
> Ah, I wasn't sure that was OK to use. Meh, since I goofed up the last
> patch I'll use that version.

My minor reason for liking 'a ?: b' - it's less typing, and makes 
avoiding long lines easier.  My major reason for liking it: 'a() ?: b' 
only evaluates a() once, unlike 'a() ? a() : b' when taking the true 
branch, which can be particularly important if a() has side effects, but 
is still an efficiency issue even when side effects are not in play. 
Yes, you can always rewrite things to use a temporary variable to avoid 
the ?: operator (which in turn can inflate a single-line expression into 
multiple lines), but there are indeed enough places in the code base 
where we rely on this extension that it doesn't hurt to add more uses.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
