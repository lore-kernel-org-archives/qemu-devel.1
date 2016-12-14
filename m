Received: from eggs.gnu.org ([2001:4830:134:3::10]:60655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cHD0J-0006LH-O7
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cHD0E-00085Z-Ld
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:06:07 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:37379 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cHD0E-00084o-9A
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:06:02 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
Date: Wed, 14 Dec 2016 20:05:44 +0300
MIME-Version: 1.0
In-Reply-To: <6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>
Cc: Wouter Verhelst <w@uter.be>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V . Lunev" <den@openvz.org>

14.12.2016 19:38, Alex Bligh wrote:
> Vladimir,
>
>>> +non-zero number of metadata contexts during negotiation. Servers SHOULD
>>> +reply to clients sending `NBD_CMD_BLOCK_STATUS without
>> backquote
> Fixed
>
>>> +    If zero queries are sent, then the server MUST return all
>>> +    the metadata contexts it knows about.
>> I think that 'all .. it knows about' is too much. What about 'return all available ..'? Anyway 'all ... it knows about' actually equals to 'all ... it wants'. There may be some private, or unrelated contexts, for example..
> This was not my wording, but I've changed it anyway to:
>
>      If zero queries are sent, then the server MUST return all
>      the metadata contexts that are available to	the client to select
>      on the given export with `NBD_OPT_SET_META_CONTEXT`.
>
> I think if they are available to select, we should list them. Thanks
> also for reminding me to document why I put the export name into the
> _LIST_ data (as it is for _SET_).
>
> However, this raises another question. Wouter deliberately made the
> query format freeform so that you could e.g. set a context like:
>
>     backup:modtime>201612081034
>
> which might (in theory) return a list of blocks which are newer than
> the given timestamp. It would clearly be impossible to return all such
> contexts. I wonder if we should carve out an exception here.
>

Interesting. Even query 'backup:modtime>*' would be a problem, not only 
empty query list.

Actually, we do not need to 'list contexts', as it is about management, 
not about data transfer. We only need a way to check, that particular 
query selects all needed contexts and no others. Just to be sure that we 
are know, what we will select by NBD_OPT_SET_META_CONTEXT with _same_ query.

So, I suggest just to say, that _LIST_ can return error if too much 
contexts are selected.|And same should be done for _SET_. And it should 
be documented that this result of query (list or error) should be equal 
for these two commands.
|


-- 
Best regards,
Vladimir
