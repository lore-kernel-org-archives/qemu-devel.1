Received: from eggs.gnu.org ([2001:4830:134:3::10]:47957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frp2s-0005Xy-SO
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frp2k-0005b9-CU
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:36:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1frp2d-0005Wi-Hd
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:36:39 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-42-armbru@redhat.com>
	<2ad9b303-8108-3f66-c478-65081fc4062a@redhat.com>
	<87woslqnay.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4c068b57-280f-7999-dc07-291282302101@redhat.com>
Date: Mon, 20 Aug 2018 13:36:35 -0500
MIME-Version: 1.0
In-Reply-To: <87woslqnay.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 41/60] json: Nicer recovery from invalid
 leading zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/20/2018 06:39 AM, Markus Armbruster wrote:

> In review of v1, we discussed whether to try matching non-integer
> numbers with redundant leading zero.  Doing that tightly in the lexer
> requires duplicating six states.  A simpler alternative is to have the
> lexer eat "digit salad" after redundant leading zero: 0[0-9.eE+-]+.
> Your suggestion for hexadecimal numbers is digit salad with different
> digits: [0-9a-fA-FxX].  Another option is their union: [0-9a-fA-FxX+-].
> Even more radical would be eating anything but whitespace and structural
> characters: [^][}{:, \t\n\r].  That idea pushed to the limit results in
> a two-stage lexer: first stage finds token strings, where a token string
> is a structural character or a sequence of non-structural,
> non-whitespace characters, second stage rejects invalid token strings.
> 
> Hmm, we could try to recover from lexical errors more smartly in
> general: instead of ending the JSON error token after the first
> offending character, end it before the first whitespace or structural
> character following the offending character.
> 
> I can try that, but I'd prefer to try it in a follow-up patch.

Indeed, that sounds like a valid approach. So, for this patch, I'm fine 
with just accepting ['0' ... '9'], then seeing if the later 
smarter-lexing change makes back-to-back non-structural tokens give 
saner error messages in general.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
