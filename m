Received: from eggs.gnu.org ([2001:4830:134:3::10]:41562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkNxK-00008H-6A
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 02:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkNxG-0000Dz-61
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 02:16:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fkNxG-0000Dn-09
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 02:16:22 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-14-armbru@redhat.com>
	<1c126eed-8b47-b61a-69d8-38176e1e586d@redhat.com>
	<87wotdxgt2.fsf@dusky.pond.sub.org>
	<2d7397fd-87e3-32a3-e5e2-38557ae65e2e@redhat.com>
Date: Tue, 31 Jul 2018 08:16:19 +0200
In-Reply-To: <2d7397fd-87e3-32a3-e5e2-38557ae65e2e@redhat.com> (Eric Blake's
	message of "Mon, 30 Jul 2018 10:25:26 -0500")
Message-ID: <87bmaoszf0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 13/23] tests: Clean up string
 interpolation around qtest_qmp_device_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: thuth@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org

Eric Blake <eblake@redhat.com> writes:

> On 07/30/2018 03:34 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>> [...]
>>> (We really want to assert that any % interpolations in our JSON parser
>>> are NOT embedded in '').
>>
>> I'll look into that, but it'll be in a separate series.
>
> Agreed.  In fact, my more ambitious series had reached that point by
> implementing %% interpolation inside strings, combined with asserting
> that %% cannot occur except within strings during the JSON parse, then
> during the JSON interpolation that the only use of % within strings
> was the %% escape (so that we no longer risk consuming a va-arg during
> string interpolation, while still benefiting from gcc's -Wformat
> checking).  So probably one of the easier things to revive, once this
> series lands.

The problem: the compiler recognizes conversion specifications the JSON
parser doesn't recognize.  Can lead to crashes or silent misbehavior.

The JSON lexer recognizes conversion specification tokens, and the JSON
parser accepts them as JSON value.  The lexer rejects conversion
specification tokens we don't support.  Conversion specifications within
tokens are not recognized.  Since only string tokens can contain '%',
conversion specifications can hide from the JSON parser only there.

I can see three ways to fix that.  All three make the JSON parser
recognize all conversion specifications.  They differ in which ones
fail.

1. Obey:

   The ones inside strings work as in sprintf().

   Example:
   "{ 'str': %s, 'act': '%.0f%%', 'max': '100%%' }", str, p * 100.0

   Encourages interpolation into strings, which is problematic, as
   explained in PATCH 11 "tests: Clean up string interpolation into QMP
   input (simple cases)".  Moreover, supporting some conversion
   specifications only in strings (e.g. %g, %.0f, %%) could be
   confusing.

2. Obey "%%" in strings, reject the rest

   You can only interpolate strings, not into strings.  To put a '%'
   intro a string, you have to double it.

   Example:
   "{ 'str': %s, 'pct': %s, 'max': '100%%' }", str, pct
   where pct = g_strdup_printf("%0.f%%", p * 100.0)

   Strings are interpreted differently when the JSON parser has
   interpolation enabled.  That's the price we have to pay for not
   having to interpolate strings containing '%'.

3. Reject:

   You can't have '%' in strings.  To get a string containing '%', you
   have to interpolate it.

   Example:
   "{ 'str': %s, 'pct': %s, 'max': %s }", str, pct, "100%"
   where pct = g_strdup_printf("%0.f%%", p * 100.0)

   This is the simplest solution.
