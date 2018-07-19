Received: from eggs.gnu.org ([2001:4830:134:3::10]:40737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fg2df-0004in-Lw
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 02:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fg2dc-0007E0-DF
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 02:42:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33862 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fg2dc-0007Ds-86
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 02:42:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180717195028.GA6691@localhost.localdomain>
	<CAFEAcA-pPsvfn7ARu_pn0HH03rZh05fLP=wr+p=hx5douSf7vA@mail.gmail.com>
Date: Thu, 19 Jul 2018 08:42:05 +0200
In-Reply-To: <CAFEAcA-pPsvfn7ARu_pn0HH03rZh05fLP=wr+p=hx5douSf7vA@mail.gmail.com>
	(Peter Maydell's message of "Tue, 17 Jul 2018 21:06:31 +0100")
Message-ID: <87a7qnk9qa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Why do we typedef every struct on QEMU?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, Philippe =?utf-8?Q?Mathieu-Da?= =?utf-8?Q?ud=C3=A9?= <f4bug@amsat.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 17 July 2018 at 20:50, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> I have been looking at patches that touch typedefs.h and
>> wondering: why do we make typedefs.h necessary at all?  Why do we
>> always add typedefs for every struct and union type in QEMU?
>>
>> Why do we prefer to write this:
>>
>> ----- qemu/typedefs.h:
>> typedef struct SomeType SomeType;
>> ----------------------
>>
>> ----- qemu/somecode.h:
>> #include <qemu/typedefs.h>
>>
>> int some_function(SomeType *a);
>> ----------------------
>>
>>
>> ...instead of simply writing this:?
>>
>> ----- qemu/somecode.h:
>> struct SomeType;
>> int some_function(struct SomeType *a);
>> ----------------------
>>
>> Is the maintenance burden of typedefs.h worth it?
>
> Personally I don't like typing "struct " all the time
> when I'm using the type...

For a different point of view (which I happen to share), see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=024ddc0ce1049298bd3cae60ae45d9c5f0fb8b9c#n318

> Note also that most typedefed structs don't go in
> typedefs.h -- the typedef is defined with the struct.
> A quick rough count suggests less than 10% are in
> typedefs.h. We only put in the ones where there's
> a lot of code that wants to use pointers to them
> as opaque types and isn't pulling in the header where
> the full struct is defined.

Correct.

> Also, this is one of the few bits of QEMU coding style
> where we're pretty consistent, so I'd rather not
> let it open to more free variation.

Agree on the value of consistency.

In my not particularly humble opinion, the QEMU coding style is one big
mistake.

This is the number of C source files and lines back when CODING_STYLE
was created[*]:

    $ git-checkout e68b98dc723
    [...]
    $ git-ls-tree -r HEAD --name-only | grep -c '\.[ch]$'
    786
    $ git-ls-tree -r HEAD --name-only | grep '\.[ch]$' | xargs wc -l | tail -n 1
      480493 total

They've since grown more than five-fold and three-fold, respectively:

    $ git-checkout v3.0.0-rc1
    [...]
    $ git-ls-tree -r HEAD --name-only | grep -c '\.[ch]$'
    4021
    $ git-ls-tree -r HEAD --name-only | grep '\.[ch]$' | xargs wc -l | tail -n 1
     1653607 total

Let's count added and deleted lines in the diff between the two
versions, ignoring added files:

    $ git-diff --numstat --diff-filter=a -l7000 e68b98dc723 | awk '/\.[ch]}?$/ { a+=$1; d+=$2 } END { print a, d }'
    86260 301104

Of the 480k lines we had back then, 300k are gone.

Thus, roughly 180k of 1654k lines still go back to e68b98dc723.  That's
less than 11%.

Had we switched to an established style (such as the kernel's) back
then, the one time pain of reformatting and its impact on git-blame
would've been long forgotten.

Instead, we've repeatedly wasted time on debating which kind of ugly we
hate less, and all we can show for our troubles is CODING_STYLE.  Which
leaves a whole lot more questions open than it answers, so we can keep
enjoying style debates.

That the code shows anything resembling consistency at all is a
testament to humanity's yearning for order within a chaotic world.


[*] "With the help of some Limoncino".
