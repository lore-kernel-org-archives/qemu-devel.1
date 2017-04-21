Received: from eggs.gnu.org ([2001:4830:134:3::10]:49004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1RME-0008Ik-HC
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1RMD-0005aF-PY
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:43:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170420040003.31074-1-famz@redhat.com>
	<20170420153016.GI3227@redhat.com>
	<20170420203250.GI4747@noname.redhat.com>
Date: Fri, 21 Apr 2017 07:43:36 +0200
In-Reply-To: <20170420203250.GI4747@noname.redhat.com> (Kevin Wolf's message
	of "Thu, 20 Apr 2017 22:32:50 +0200")
Message-ID: <87pog61fjr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] sheepdog: Set error when connection fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, sheepdog@lists.wpkg.org, qemu-block@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Fam Zheng <famz@redhat.com>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 20.04.2017 um 17:30 hat Daniel P. Berrange geschrieben:
>> On Thu, Apr 20, 2017 at 12:00:03PM +0800, Fam Zheng wrote:
>> > Signed-off-by: Fam Zheng <famz@redhat.com>
>> > ---
>> >  block/sheepdog.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> > 
>> > diff --git a/block/sheepdog.c b/block/sheepdog.c
>> > index fb9203e..7e889ee 100644
>> > --- a/block/sheepdog.c
>> > +++ b/block/sheepdog.c
>> > @@ -608,6 +608,7 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
>> >          qemu_set_nonblock(fd);
>> >      } else {
>> >          fd = -EIO;
>> > +        error_setg(errp, "Failed to connect to sheepdog server");
>> >      }
>> 
>> This doesn't make much sense to me. The lines just above the
>> diff context have this:
>> 
>>     fd = socket_connect(s->addr, errp, NULL, NULL);
>> 
>> socket_connect should have already reported an error on "errp"
>> in the scenario that 'fd == -1'.
>
> By the way, am I the only one who thinks that having errp anywhere else
> than as the last argument is bad style? I can easily see myself missing
> that this functions sets it because the last argument is NULL.

Yes, it's bad style because it's suprising.  Worth fixing.
