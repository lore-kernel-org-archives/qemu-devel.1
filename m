Received: from eggs.gnu.org ([2001:4830:134:3::10]:36025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpnKp-0004pL-6x
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 00:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpnKg-0007YX-W4
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 00:22:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37744 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpnKg-0007Vy-4A
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 00:22:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1526916378.git.simon@ruderich.org>
	<851d095cd457109e4a22a2e5ecd36ccbdacbf48b.1526916378.git.simon@ruderich.org>
	<20180810103650.GA2391@work-vm> <20180814141826.GA26558@ruderich.org>
	<871sb1t0cn.fsf@dusky.pond.sub.org>
	<20180814190329.GA13798@ruderich.org>
Date: Wed, 15 Aug 2018 06:22:51 +0200
In-Reply-To: <20180814190329.GA13798@ruderich.org> (Simon Ruderich's message
	of "Tue, 14 Aug 2018 21:03:29 +0200")
Message-ID: <87pnykqmw4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

Simon Ruderich <simon@ruderich.org> writes:

> On Tue, Aug 14, 2018 at 05:49:12PM +0200, Markus Armbruster wrote:
>>> On Fri, Aug 10, 2018 at 11:36:51AM +0100, Dr. David Alan Gilbert wrote:
>>>>> --- a/hmp-commands.hx
>>>>> +++ b/hmp-commands.hx
>>
>> Subject claims "qmp: add", but the patch also adds to hmp.  Recommend to
>> split the patch into QMP and HMP part.
>
> Hello,
>
> Sure, I can do that.
>
>>> qapi/misc.json seems to always use 'int' for integer types. Is
>>> this value large enough on 64-bit architectures?
>>
>> Yes.  QAPI's int translates to int64_t.
>
> Thanks.
>
>>> Just curious, what is the difference between 's' and 'F'. Is that
>>> only for documentation purposes (and maybe tab completion) or is
>>> the usage different? I noticed existing code uses qdict_get_str()
>>> for both 's' and 'F'.
>>
>> The main behavioral difference is completion.
>
> Good to know, thanks.
>
>> I recommend to start with the QMP interface.  Parameters are unordered
>> there.  memsave and pmemsave both take mandatory @val, @size, @filename.
>> memsave additionally takes optional @cpu-index.
>
> Yes.
>
>> Your pmemload has pmemsave's arguments plus and mandatory @offset.
>> Rationale for adding @offset?  You may have answered this question
>> already; pointer to that answer would be fine.
>
> My initial patch didn't have the offset. It was suggested by Eric
> Blake in <0a960aa8-2a3f-8667-3d46-cecf8e65e482@redhat.com>:
>
> On Tue, Apr 10, 2018 at 04:33:03PM -0500, Eric Blake wrote:
>> Do you additionally need an offset where to start reading from within
>> the file (that is, since you already have the 'size' parameter to avoid
>> reading the entire file, and the 'val' parameter to target anywhere in
>> physical memory, how do I start reading anywhere from the file)?
>
> It sounded useful to me so I added it.

Feels like an optional parameter to me.

>> Once we got the QMP interface nailed down, we can move to the HMP
>> interface.
>
> Good point.
>
>> These two should become a separate bug fix patch.  The bug being fixed
>> is completion.
>
> Sure, they are in separate patches. Just wanted to show the
> general changes I applied from the reviews.
>
> Thanks for the review.
>
> Regards
> Simon
