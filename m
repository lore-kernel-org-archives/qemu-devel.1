Received: from eggs.gnu.org ([2001:4830:134:3::10]:36826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elfring@users.sourceforge.net>) id 1d93S5-0000hZ-BX
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elfring@users.sourceforge.net>) id 1d93S2-0006Vt-AE
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:49:21 -0400
Received: from mout.web.de ([212.227.15.14]:64147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elfring@users.sourceforge.net>)
	id 1d93S1-0006MG-VO
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:49:18 -0400
References: <20170512033543.6789-1-f4bug@amsat.org>
	<20170512033543.6789-2-f4bug@amsat.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <a1881660-43ef-b7b1-8642-eb1df934ae8a@users.sourceforge.net>
Date: Fri, 12 May 2017 07:48:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170512033543.6789-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 1/5] coccinelle: add a script to
 optimize tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Julia Lawall <julia.lawall@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>

>  create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci

Will an other subdirectory be more appropriate for this SmPL script?


> +// Coccinelle helpful issue:
> +// https://github.com/coccinelle/coccinelle/issues/86

I am curious if such an information source will trigger further
software evolution.
How do you think about to mention also the corresponding topic
“Propagating values back from Python script to SmPL rule with other metavariable
type than “identifier”” just for the case that the issue number can be fragile?


> +@match@ // match shri*+andi* pattern, calls script verify_len
> +identifier ret, arg;
> +constant ofs, len;
> +identifier shr_fn =~ "^tcg_gen_shri_";
> +identifier and_fn =~ "^tcg_gen_andi_";
> +position shr_p;
> +position and_p;
> +@@
> +(
> +shr_fn@shr_p(ret, arg, ofs);
> +and_fn@and_p(ret, ret, len);
> +)

My software development attention was caught also a bit by this specification.
How much do you care for coding style there?

* Two repeated SmPL key words while using the variable list functionality before.

* I wonder about the relevance for the parentheses.
  Did you try to express a disjunction for the semantic patch language
  besides the usage of two function (or macro) calls?


> +        print "  candidate", "IS" if is_optimizable else "is NOT", "optimizable"

Would you like to move this information display into a separate function?

Do you care if the “print” is the usage of a function call or a statement?
https://docs.python.org/3.0/whatsnew/3.0.html#print-is-a-function


> +-shr_fn@shr_p(ret, arg, ofs);
> +-and_fn@and_p(ret, ret, len);
> ++extract_fn(ret, arg, ofs, len);

Are there any more cases to consider for the sown function call replacement?

Regards,
Markus
