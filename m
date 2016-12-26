Received: from eggs.gnu.org ([2001:4830:134:3::10]:55216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cLWeI-0007G8-RK
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 09:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cLWeF-0007W7-PL
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 09:53:14 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:35771 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cLWeF-0007VB-7a
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 09:53:11 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
	<94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
	<0F1DC4AE-5C9E-4AE6-8141-AE6B398EBF73@alex.org.uk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2812e3e2-983a-42de-a55f-590a87b7fece@virtuozzo.com>
Date: Mon, 26 Dec 2016 17:52:54 +0300
MIME-Version: 1.0
In-Reply-To: <0F1DC4AE-5C9E-4AE6-8141-AE6B398EBF73@alex.org.uk>
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
Cc: Wouter Verhelst <w@uter.be>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V . Lunev" <den@openvz.org>

14.12.2016 21:17, Alex Bligh wrote:
>> On 14 Dec 2016, at 17:55, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>
>>> Hmmm... Well in the '*' case, it's up to the namespace as to how it parses things, so '*' could be prohibited entirely or mean 'return the first 20 matching' or similar. So that's less of a problem. And 'set all' doesn't exist (unlike 'list all').
>>>
>>> I think in the LIST case we should allow the server to omit contexts under certain circumstances, and allow SET to return ETOOBIG.
>>>
>> We can't prohibit '*' as query string as implementation defined. And we shouldn't (I think) define its meaning.
> Those two statements appear to me to contradict each other. The current documentation *does* define the query string (to the right of the colon) as implementation defined. I'm thus not sure what you mean.
>
>> Opposite, we can define, that query must not select more than 20 contexts, but I'm not sure that this is good.
> Each query can select from only one namespace in the current document (Wouter explained why). However, you can specify multiple queries.
>
> I don't think we need to define a hard limit of a particular number.
>
>> So, do you mean
>>
>>   list('backup:modtime>*') -> empty list
> The result of that would depend on however the 'backup' context was defined, meaning it had the options of:
> * ETOOBIG
> * Listing some subset of available contexts (arguably 'none' is a subset)
>
>>   set('backup:modtime>*') -> ETOOBIG
> Again, the result of that would depend on however the 'backup' context was defined, meaning it had the options of:
> * ETOOBIG
> * Listing some subset of available contexts (arguably 'none' is a subset)
> ... and it need not make the same choice as above, but I agree it would be logical for it to do so.
>
> As any form of wildcarding within a query refers to one particular namespace (as a query by its nature specifies a single namespace), we don't have to worry about the way wildcarding works in the standard, as Wouter pointed out. We merely need to provide that ETOOBIG and listing a subset are acceptable responses.
>
> What we do need to decide is what the response to list() (i.e. a list with a zero length list of queries) does. It's currently defined to return every context from every namespace. Options would include
> * ETOOBIG
> * Listing some subset of available contexts (arguably 'none' is a subset)
> * Allowing abbreviation of algorithmically specified contexts (e.g. in this case just returning 'backup:' to represent all available backup contexts)

Shouldn't we add some flags to REP_META_CONTEXT, for client to be 
insure, is returned string a direct context name or some kind of 
wildcard?|| Just a flags field, with one flag defined for now: 
|NBD_REP_META_CONTEXT_LEAF and others reserved.|


-- 
Best regards,
Vladimir
