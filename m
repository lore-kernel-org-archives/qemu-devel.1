Received: from eggs.gnu.org ([209.51.188.92]:50765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtVmQ-0003nX-D7
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtVmP-0002Ah-5m
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:59:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gtVmO-00027O-Sh
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:59:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so2439646wmj.1
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 02:59:08 -0800 (PST)
References: <20190211163829.10297-1-pbonzini@redhat.com>
	<87imxppe68.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8f8ef754-0003-77e2-0fd1-e10f3ab2e3e5@redhat.com>
Date: Tue, 12 Feb 2019 11:59:06 +0100
MIME-Version: 1.0
In-Reply-To: <87imxppe68.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Kconfig: add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: peter.maydell@linaro.org, thuth@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org

On 12/02/19 10:08, Markus Armbruster wrote:
> Please wrap your lines at column 70 or so.  Humans tend to have trouble
> following long lines with their eyes (I sure do).  Typographic manuals
> suggest to limit columns to roughly 60 characters for exactly that
> reason[*].

Yup, fixed in v2.

>> +Each QEMU target enables a subset of the boards, devices and buses that are included
>> +in QEMU's source code.  As a result, each QEMU executable only links a small subset
> 
> Really?  Hmm...
> 
> $ size aarch64-softmmu/qemu-system-aarch64
>    text	   data	    bss	    dec	    hex	filename
> 19183216	7200124	 592732	26976072	19b9f48	aarch64-softmmu/qemu-system-aarch64
> $ size -t `find -name \*.o `| grep TOT
> 92713559	18652227	1183961440	1295327226	4d351ffa	(TOTALS)
> 
> Yep, really.

Haha. :)

>> +  Optionally, a condition for applying the default value can be added with
>> +  ``if``.  A config option can have any number of default values (usually, if more than
>> +  one default is present, they will have different conditions). If multiple
>> +  default values satisfy their condition, only the first defined one is active.
> 
> Hmm.  Is "multiple default values, first one wins" a healthy state?
> How obvious is "first defined" to humans?  

It certainly helps that we never have more than one default. :)

I could also be persuaded to remove "default n", so that multiple
"default y" clauses are just an OR of the conditions and the ordering
does not matter.

Are multiple "default y" clauses useful?  They were there in earlier
versions of the patches, for now "imply" has removed the need
everywhere.  However, I'm not sure it's a good idea to remove them
altogether before we try to extend Kconfig to more features.  (A
secondary effect of the documentation is to clarify the current scope of
Kconfig).

>> +**reverse default** (weak reverse dependency): ``imply <symbol> [if <expr>]``
> 
> If "reverse default" can be regarded as weak reverse dependency, could
> "default value" be regarded as weak (forward) dependency?

"default n if" could, but we never use it.  This also shows how we use
the language in a very limited way, according to the very simple rules
in the second part of the document; but even Linux only has a handful of
occurrences of "default n if".

>> +
>> +  This is similar to ``select`` as it applies a lower limit of ``y`` to another
>> +  symbol.  However, the lower limit is only a default and the "implied" symbol's
>> +  value may still be set to ``n`` from a ``default-configs/*.mak`` files.  The
> 
> I'm afraid I don't get "lower limit".  What's the ordering relation?

False < true, so "lower limit of y" means "tries to force to y".  The
difference is that a contradiction is ignored by "imply" (and then the
symbol remains at n), while it causes a build error for "select".

Paolo
