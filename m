Received: from eggs.gnu.org ([2001:4830:134:3::10]:41716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea0jD-00055t-Vk
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea0jA-0006a9-3I
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:54:44 -0500
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:36905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ea0j9-0006ZI-TJ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:54:40 -0500
Received: by mail-pf0-x236.google.com with SMTP id p1so4552553pfh.4
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 06:54:39 -0800 (PST)
References: <20171218174552.18871-1-richard.henderson@linaro.org>
	<20171218174552.18871-2-richard.henderson@linaro.org>
	<CAFEAcA9A85CnzizK8rYNZCDgmszG5NL3=1QOetTcOS3gijzCAA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fad4dbc5-251d-48af-d092-a10b1d945caf@linaro.org>
Date: Fri, 12 Jan 2018 06:54:35 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9A85CnzizK8rYNZCDgmszG5NL3=1QOetTcOS3gijzCAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/23] scripts: Add decodetree.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 01/12/2018 03:57 AM, Peter Maydell wrote:
> I asked on #qemu-devel for some review from people who are more
> familiar with Python than I am. One of the suggestions (from
> Marc-André Lureau) was to run pycodestyle on this and fix the
> (mostly coding style nits) reported by it. (pycodestyle may
> be called 'pep8' on older distros.)

Thanks, I'll have a look.

>> +# For unnamed_field, the first number is the least-significant bit position of
>> +# the field and the second number is the length of the field.  If the 's' is
>> +# present, the field is considered signed.  If multiple unnamed_fields are
>> +# present, they are concatenated.  In this way one can define disjoint fields.
> 
> This syntax lets you specify that fields other than the first one in
> a concatenated set are signed, like
>     10:5 | 3:s5
> That doesn't seem to me like it's meaningful. Shouldn't the signedness
> or otherwise be a property of the whole extracted field, rather than
> an individual component of it? (In practice creating a signed combined
> value is implemented by doing the most-significant component as sextract,
> obviously.)

You're right that it's not especially meaningful.  But since I use deposit to
compose the pieces, any extraneous sign on a less significant component gets
smooshed.  So nothing bad happens in the end.  Which is why I decided not to check.

> Do we syntax-check for accidentally specifying a field-def whose
> components overlap (eg "3:5 0:5")? I think we should, but I didn't
> see a check in a quick scan through the parsing code.

Probably not...  something else for unit testing.

>> +# If any fixedbit_elt or field_elt appear then all 32 bits must be defined.
>> +# Padding with a fixedbit_elt of all '.' is an easy way to accomplish that.
> 
> What is a format that doesn't specify the full 32 bits useful for?
> Do you have an example of one?

No.  I'm not sure what I was thinking of there.  I'm pretty sure the code
doesn't allow that.

> I notice in the generated code that all the trans_FOO functions
> are global, not file-local. That seems like it's going to lead
> to name clashes down the line, especially if/when we ever get
> to supporting multiple different target architectures in a single
> QEMU binary.

I was initially thinking that I'd have the translator functions in a different
file, and because of that they would of course have to be global.  I had
thought far enough ahead to add command-line options to change the names and
prefixes.

But as it has turned out, putting the translator functions into the same file
has worked out well.  I should probably rearrange this.

> Also from the generated code, "arg_incdec2_pred" &c don't follow
> our coding style preference for CamelCase for typedef names. On
> the other hand it's not immediately obvious how best to pick
> a camelcase approach for them...

Yeah, auto-generating names in different ways is tricky.

> A --help would be helpful (as would documenting the command
> line syntax in the comment at the top of the file).

Sure.

Thanks!


r~
