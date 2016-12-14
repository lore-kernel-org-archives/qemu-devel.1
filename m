Received: from eggs.gnu.org ([2001:4830:134:3::10]:46537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cHDmp-0006YK-Rz
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cHDmm-0005ox-Or
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:56:15 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:30289 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cHDmm-0005nf-Bb
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:56:12 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
Date: Wed, 14 Dec 2016 20:55:56 +0300
MIME-Version: 1.0
In-Reply-To: <5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
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

14.12.2016 20:36, Alex Bligh wrote:
>> On 14 Dec 2016, at 17:05, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>> However, this raises another question. Wouter deliberately made the
>>> query format freeform so that you could e.g. set a context like:
>>>
>>>     backup:modtime>201612081034
>>>
>>> which might (in theory) return a list of blocks which are newer than
>>> the given timestamp. It would clearly be impossible to return all such
>>> contexts. I wonder if we should carve out an exception here.
>>>
>>>
>> Interesting. Even query 'backup:modtime>*' would be a problem, not only empty query list.
>>
>> Actually, we do not need to 'list contexts', as it is about management, not about data transfer. We only need a way to check, that particular query selects all needed contexts and no others. Just to be sure that we are know, what we will select by NBD_OPT_SET_META_CONTEXT with _same_ query.
>>
>> So, I suggest just to say, that _LIST_ can return error if too much contexts are selected. And same should be done for _SET_. And it should be documented that this result of query (list or error) should be equal for these two commands.
> (two CCs that always bounce removed)
>
> Hmmm... Well in the '*' case, it's up to the namespace as to how it parses things, so '*' could be prohibited entirely or mean 'return the first 20 matching' or similar. So that's less of a problem. And 'set all' doesn't exist (unlike 'list all').
>
> I think in the LIST case we should allow the server to omit contexts under certain circumstances, and allow SET to return ETOOBIG.
>

We can't prohibit '*' as query string as implementation defined. And we 
shouldn't (I think) define its meaning. Opposite, we can define, that 
query must not select more than 20 contexts, but I'm not sure that this 
is good.

So, do you mean

   list('backup:modtime>*') -> empty list
   set('backup:modtime>*') -> ETOOBIG

? For me this looks strange.

-- 
Best regards,
Vladimir
