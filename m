Received: from eggs.gnu.org ([2001:4830:134:3::10]:44003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZeJR-0006qB-Gt
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZeJO-0000oN-6m
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:26:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dZeJN-0000nL-Uo
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:26:18 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170724121409.8623-1-dgilbert@redhat.com>
	<8c776e3a-a744-86e2-ba68-bf60e5234e20@redhat.com>
	<20170724141426.GB2127@work-vm>
Date: Mon, 24 Jul 2017 16:26:15 +0200
In-Reply-To: <20170724141426.GB2127@work-vm> (David Alan Gilbert's message of
	"Mon, 24 Jul 2017 15:14:26 +0100")
Message-ID: <87r2x552t4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hmp/(p)memsave: Allow >32bit file size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, admin@manateeshome.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Thomas Huth (thuth@redhat.com) wrote:
>> On 24.07.2017 14:14, Dr. David Alan Gilbert (git) wrote:
>> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> > 
>> > memsave and pmemsave only take 32bit size arguments in HMP at the
>> > moment; let them take 64bit values.
>> > 
>> > Reported-by: Pierre Kim <admin@manateeshome.com>
>> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> > ---
>> >  hmp-commands.hx | 4 ++--
>> >  hmp.c           | 4 ++--
>> >  2 files changed, 4 insertions(+), 4 deletions(-)
>> > 
>> > diff --git a/hmp-commands.hx b/hmp-commands.hx
>> > index 1941e19932..ddf77ae7ac 100644
>> > --- a/hmp-commands.hx
>> > +++ b/hmp-commands.hx
>> > @@ -829,7 +829,7 @@ ETEXI
>> >  
>> >      {
>> >          .name       = "memsave",
>> > -        .args_type  = "val:l,size:i,filename:s",
>> > +        .args_type  = "val:l,size:l,filename:s",
>> >          .params     = "addr size file",
>> >          .help       = "save to disk virtual memory dump starting at 'addr' of size 'size'",
>> >          .cmd        = hmp_memsave,
>> > @@ -843,7 +843,7 @@ ETEXI
>> >  
>> >      {
>> >          .name       = "pmemsave",
>> > -        .args_type  = "val:l,size:i,filename:s",
>> > +        .args_type  = "val:l,size:l,filename:s",
>> >          .params     = "addr size file",
>> >          .help       = "save to disk physical memory dump starting at 'addr' of size 'size'",
>> >          .cmd        = hmp_pmemsave,
>> > diff --git a/hmp.c b/hmp.c
>> > index bf1de747d5..dfbd615380 100644
>> > --- a/hmp.c
>> > +++ b/hmp.c
>> > @@ -1066,7 +1066,7 @@ void hmp_cpu(Monitor *mon, const QDict *qdict)
>> >  
>> >  void hmp_memsave(Monitor *mon, const QDict *qdict)
>> >  {
>> > -    uint32_t size = qdict_get_int(qdict, "size");
>> > +    uint64_t size = qdict_get_int(qdict, "size");
>> >      const char *filename = qdict_get_str(qdict, "filename");
>> >      uint64_t addr = qdict_get_int(qdict, "val");
>> >      Error *err = NULL;
>> > @@ -1083,7 +1083,7 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
>> >  
>> >  void hmp_pmemsave(Monitor *mon, const QDict *qdict)
>> >  {
>> > -    uint32_t size = qdict_get_int(qdict, "size");
>> > +    uint64_t size = qdict_get_int(qdict, "size");
>> >      const char *filename = qdict_get_str(qdict, "filename");
>> >      uint64_t addr = qdict_get_int(qdict, "val");
>> >      Error *err = NULL;
>> 
>> The "size" parameter of the qmp_memsave() and qmp_pmemsave() function is
>> a signed integer (int64_t) ... could we get into trouble here if the
>> integer is really big? E.g. should we make "size" here signed, too, and
>> then add a sanity check for "size >= 0" ?
>
> OK, yes, I'll fix that for the sizes;

I think we should fix QMP instead: use type 'size' instead of 'int' for
byte counts.  There might be more than just memsave and pmemsave.

>                                        qmp_pmemsave hangs with -ve sizes
> (which probably needs fixing another time).
>
> V.2 coming up.
>
> Dave
>
>>  Thomas
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
