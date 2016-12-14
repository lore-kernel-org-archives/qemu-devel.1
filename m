Received: from eggs.gnu.org ([2001:4830:134:3::10]:41218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cHDRP-00066x-3w
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cHDRL-0008AI-SG
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:34:07 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:44644 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cHDRL-00089t-GD
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:34:03 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
	<20161214170956.32o6b27baf3bkmd4@grep.be>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c8e51c51-e395-5172-092c-f74ccb1791c4@virtuozzo.com>
Date: Wed, 14 Dec 2016 20:33:48 +0300
MIME-Version: 1.0
In-Reply-To: <20161214170956.32o6b27baf3bkmd4@grep.be>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>
Cc: nbd-general@lists.sourceforge.net, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Pavel Borzenkov <pborzenkov@virtuozzo.com>, stefanha@redhat.com, "Denis V . Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

14.12.2016 20:09, Wouter Verhelst wrote:
> On Wed, Dec 14, 2016 at 03:08:40PM +0000, Alex Bligh wrote:
>> (NB: I've already applied this and pushed it)
> Thanks.
>
>> * Change NBD_OPT_LIST_METADATA etc. to explicitly send a list of queries
>>    and add a count of queries so we can extend the command later (rather than
>>    rely on the length of option)
> Sure, that works.
>
>> * For NBD_OPT_LIST_METADATA make absence of any query (as opposed to zero
>>    length query) list all contexts, as absence of any query is now simple.
>>
>> * Move definition of namespaces in the document to somewhere more appopriate.
>>
>> * Various other minor changes as discussed on the mailing list
> Right. I think we're getting close to a good spec now, for this thing.
>
> One thing I've been thinking about that we might want to add:
>
> There may be cases where a server, in performing the required calls to
> be able to handle a BLOCK_STATUS request, will end up with more
> information than the client asked; e.g., if the client asked information
> in the base:allocation context on an extent at offset X of length Y,
> then the server might conceivably do an lseek(SEEK_DATA) and/or
> lseek(SEEK_HOLE). The result of that call might be that the file offset
> will now point to a location Z, where Z > (X+Y).
>
> Currently, our spec says "the sum of the *length* fields MUST not be
> greater than the overall *length* of request". This means that in
> essense, the server then has to throw away the information it has on the
> range Z - (X + Y). In case a client was interested in that information,
> that seems like a waste. I would therefore like to remove that
> requirement, by rephrasing that "sum of the *length* fields" thing into
> something along the following lines:
>
>    In case the server returns N extents, the sum of the *length* fields
>    of the first N-1 extents MUST NOT be greater than the overall *length*
>    of the request. The final extent MAY exceed the length of the request
>    if the server has that information anyway as a side effect of looking
>    up the required information and wishes to share it.
>
> This would then result in the fact that the "length" field in the
> BLOCK_STATUS command would be little more than a hint, since we're
> saying that a server can return more data than requested (if it's
> available anyway) and less data than requested (if it would be too
> resource-intensive to provide all the information). Not sure whether all
> that makes much sense anymore, but hey.
>
> In addition, the combination of a server providing more information than
> requested with a "REQ_ONE" flag and a length field of zero could be an
> interesting way to enumerate a whole export, too. Essentially, we could
> define that as a client saying "I'm interested in what the size of the
> extent at offset X is, and what its properties are".
>
> Thoughts?
>

Good, I'm for it. May be, in such wording there are too much information 
about implementation (again, server can do it if it _wants_, is it a 
side effect or not is implementation defined). In other words, "if the 
server..." is better read as an example, not requirement. But it's not 
important.

-- 
Best regards,
Vladimir
