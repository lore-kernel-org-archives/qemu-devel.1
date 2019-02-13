Received: from eggs.gnu.org ([209.51.188.92]:41072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtpMd-00023p-M0
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtpET-0003uz-D0
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:45:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gtpEN-0003k9-Ms
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:45:21 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190211163829.10297-1-pbonzini@redhat.com>
	<87imxppe68.fsf@dusky.pond.sub.org>
	<8f8ef754-0003-77e2-0fd1-e10f3ab2e3e5@redhat.com>
Date: Wed, 13 Feb 2019 08:45:13 +0100
In-Reply-To: <8f8ef754-0003-77e2-0fd1-e10f3ab2e3e5@redhat.com> (Paolo
	Bonzini's message of "Tue, 12 Feb 2019 11:59:06 +0100")
Message-ID: <87d0nwjfna.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] Kconfig: add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: peter.maydell@linaro.org, thuth@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 12/02/19 10:08, Markus Armbruster wrote:
>> Please wrap your lines at column 70 or so.  Humans tend to have trouble
>> following long lines with their eyes (I sure do).  Typographic manuals
>> suggest to limit columns to roughly 60 characters for exactly that
>> reason[*].
>
> Yup, fixed in v2.
>
>>> +Each QEMU target enables a subset of the boards, devices and buses that are included
>>> +in QEMU's source code.  As a result, each QEMU executable only links a small subset
>> 
>> Really?  Hmm...
>> 
>> $ size aarch64-softmmu/qemu-system-aarch64
>>    text	   data	    bss	    dec	    hex	filename
>> 19183216	7200124	 592732	26976072	19b9f48	aarch64-softmmu/qemu-system-aarch64
>> $ size -t `find -name \*.o `| grep TOT
>> 92713559	18652227	1183961440	1295327226	4d351ffa	(TOTALS)
>> 
>> Yep, really.
>
> Haha. :)
>
>>> +  Optionally, a condition for applying the default value can be added with
>>> +  ``if``.  A config option can have any number of default values (usually, if more than
>>> +  one default is present, they will have different conditions). If multiple
>>> +  default values satisfy their condition, only the first defined one is active.
>> 
>> Hmm.  Is "multiple default values, first one wins" a healthy state?
>> How obvious is "first defined" to humans?  
>
> It certainly helps that we never have more than one default. :)

True!

> I could also be persuaded to remove "default n", so that multiple
> "default y" clauses are just an OR of the conditions and the ordering
> does not matter.

I'm looking for something that doesn't involve too much global
reasoning.

"All default directives must provide the same value; their conditions
are ORed" feels fine to me.  Order doesn't matter then.  "if <expr>"
really means "if", not "if-and-only-if", and that's fine.

Additionally permitting an *unconditional* default with the negated
value would still be okay, I guess.  But I'd do that only when we have a
use.

> Are multiple "default y" clauses useful?  They were there in earlier
> versions of the patches, for now "imply" has removed the need
> everywhere.  However, I'm not sure it's a good idea to remove them
> altogether before we try to extend Kconfig to more features.  (A
> secondary effect of the documentation is to clarify the current scope of
> Kconfig).

My general advice would be YAGNI.  However, keeping currently unused
features around while we grow Kconfig makes sense to me.

>>> +**reverse default** (weak reverse dependency): ``imply <symbol> [if <expr>]``
>> 
>> If "reverse default" can be regarded as weak reverse dependency, could
>> "default value" be regarded as weak (forward) dependency?
>
> "default n if" could, but we never use it.  This also shows how we use
> the language in a very limited way, according to the very simple rules
> in the second part of the document; but even Linux only has a handful of
> occurrences of "default n if".
>
>>> +
>>> +  This is similar to ``select`` as it applies a lower limit of ``y`` to another
>>> +  symbol.  However, the lower limit is only a default and the "implied" symbol's
>>> +  value may still be set to ``n`` from a ``default-configs/*.mak`` files.  The
>> 
>> I'm afraid I don't get "lower limit".  What's the ordering relation?
>
> False < true, so "lower limit of y" means "tries to force to y".  The
> difference is that a contradiction is ignored by "imply" (and then the
> symbol remains at n), while it causes a build error for "select".

Can we use this explanation to rephrase the documentation in simpler
language?

Let me summarize to see whether I got it.  Please correct
misunderstandings.

* "depends on" forces to false unless condition is met

* "select" forces to true if condition is met

* Contradictions between "depends on" and "select" are rejected

* If neither applies, default-configs/*.mak may supply the value

* If it doesn't, "default" / "imply" supply the value if condition is
  met

* What about contradictions between "default" / "imply"?


PS: Thanks for writing down intended use in "Guidelines for writing
Kconfig files", not just the language specification, makes the document
so much more useful.
