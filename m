Received: from eggs.gnu.org ([2001:4830:134:3::10]:55199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKBm-0002ch-5X
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:13:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKBh-0002mb-4E
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:13:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdKBg-0002lx-UV
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:13:17 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 183F0A89D
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 17:13:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170203122826.GI3208@work-vm> (David Alan Gilbert's message of
	"Fri, 3 Feb 2017 12:28:27 +0000")
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-18-git-send-email-quintela@redhat.com>
	<20170203122826.GI3208@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 13 Feb 2017 18:13:07 +0100
Message-ID: <87fuji3tgc.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 17/17] migration: flush receive queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Each time that we sync the bitmap, it is a possiblity that we receive
>> a page that is being processed by a different thread.  We fix this
>> problem just making sure that we wait for all receiving threads to
>> finish its work before we procedeed with the next stage.
>> 
>> We are low on page flags, so we use a combination that is not valid to
>> emit that message:  MULTIFD_PAGE and COMPRESSED.
>> 
>> I tried to make a migration command for it, but it don't work because
>> we sync the bitmap sometimes when we have already sent the beggining
>> of the section, so I just added a new page flag.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Is there something that makes sure that the very last page is marked
> with a flush to ensure that the read completes before we start
> trying to do anything after ram_load ?
> As I read this the flag gets added to the first page of the next round.

Yes.  It is easier.  We handle this flag before we handle the following
page, so it is safe, no?

>> 
>> +        if ((flags & (RAM_SAVE_FLAG_MULTIFD_PAGE|RAM_SAVE_FLAG_COMPRESS))
>> +                  == (RAM_SAVE_FLAG_MULTIFD_PAGE|RAM_SAVE_FLAG_COMPRESS)) {
>> +            multifd_flush();
>> +            flags = flags & ~RAM_SAVE_FLAG_COMPRESS;
>> +        }
>>          if (flags & (RAM_SAVE_FLAG_COMPRESS | RAM_SAVE_FLAG_PAGE |
>>                       RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE |
>>                       RAM_SAVE_FLAG_MULTIFD_PAGE)) {

Here is where we make sure than we have done.

<think, think , think ...>

Ok,  I think what you mean, what we do for the last page of the last
round.  Will try to move it to the place that you asked for.  Not
trivial because we generate the header before we do anything else, and
the last page could not be a multifd one.  Will think about it.

Thanks, Juan.


>> -- 
>> 2.9.3
>> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
