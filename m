Received: from eggs.gnu.org ([2001:4830:134:3::10]:44970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo8Qg-0001Ev-2D
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo8QZ-0005NW-Ox
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:30:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49434 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fo8QZ-0005Ll-Hp
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:30:07 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-57-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0b4553ab-1938-0632-89a4-fa77d0518d76@redhat.com>
Date: Fri, 10 Aug 2018 09:30:02 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-57-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 56/56] docs/interop/qmp-spec: How to force
 known good parser state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/08/2018 07:03 AM, Markus Armbruster wrote:
> Section "QGA Synchronization" specifies that sending "a raw 0xFF
> sentinel byte" makes the server "reset its state and discard all
> pending data prior to the sentinel."  What actually happens there is a
> lexical error, which will produce one ore more error responses.
> Moreover, it's not specific to QGA.

Hoisting my review of this, as you may want to move it sooner in the series.

> 
> Create new section "Forcing the JSON parser into known-good state" to
> document the technique properly.  Rewrite section "QGA
> Synchronization" to document just the other direction, i.e. command
> guest-sync-delimited.
> 
> Section "Protocol Specification" mentions "synchronization bytes
> (documented below)".  Delete that.
> 
> While there, fix it not to claim '"Server" is QEMU itself', but
> '"Server" is either QEMU or the QEMU Guest Agent'.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/interop/qmp-spec.txt | 37 ++++++++++++++++++++++++-------------
>   1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
> index 1566b8ae5e..d4a42fe2cc 100644
> --- a/docs/interop/qmp-spec.txt
> +++ b/docs/interop/qmp-spec.txt
> @@ -20,9 +20,9 @@ operating system.
>   2. Protocol Specification
>   =========================
>   
> -This section details the protocol format. For the purpose of this document
> -"Client" is any application which is using QMP to communicate with QEMU and
> -"Server" is QEMU itself.
> +This section details the protocol format. For the purpose of this
> +document, "Server" is either QEMU or the QEMU Guest Agent, and
> +"Client" is any application communicating with it via QMP.
>   

Broadens the term "QMP" to mean any client speaking to a qemu 
machine-readable server (previously, we tended to treat "QMP" as the 
direct-to-qemu service, and "QGA" as the guest agent service). I can 
live with that, especially since this document was already mentioning QGA.

>   JSON data structures, when mentioned in this document, are always in the
>   following format:
> @@ -34,9 +34,8 @@ by the JSON standard:
>   
>   http://www.ietf.org/rfc/rfc7159.txt
>   
> -The protocol is always encoded in UTF-8 except for synchronization
> -bytes (documented below); although thanks to json-string escape
> -sequences, the server will reply using only the strict ASCII subset.
> +The sever expects its input to be encoded in UTF-8, and sends its
> +output encoded in ASCII.
>   

Perhaps worth documenting is the range of JSON numbers produced by qemu 
(maybe as a separate patch). Libvirt just hit a bug with the jansson 
library making it extremely difficult to parse JSON containing numbers 
larger than INT64_MAX, when compared to yajl which had a way to support 
up to UINT64_MAX.

https://bugzilla.redhat.com/show_bug.cgi?id=1614569

Knowing that qemu sends numbers larger than INT64_MAX with the intent 
that they not be truncated/rounded by conversion to double can be a 
vital piece of information for implementing a client, when it comes to 
picking a particular library for JSON parsing.

>   For convenience, json-object members mentioned in this document will
>   be in a certain order. However, in real protocol usage they can be in
> @@ -215,16 +214,28 @@ Some events are rate-limited to at most one per second.  If additional
>   dropped, and the last one is delayed.  "Similar" normally means same
>   event type.  See qmp-events.txt for details.
>   
> -2.6 QGA Synchronization
> +2.6 Forcing the JSON parser into known-good state
> +-------------------------------------------------
> +
> +Incomplete or invalid input can leave the server's JSON parser in a
> +state where it can't parse additional commands.  To get it back into
> +known-good state, the client should provoke a lexical error.
> +
> +The cleanest way to do that is sending an ASCII control character
> +other than '\t' (horizontal tab), '\r' (carriage return), and '\n'

s/and/or/

> +(new line).
> +
> +Sadly, older versions of QEMU can fail to flag this as an error.  If a
> +client needs to deal with them, it should send a 0xFF byte.

Here's where we have the choice of whether to intentionally document 
0xff as an intentional parser reset, instead of a lexical error. If so, 
the advice to provoke a lexical error via an ASCII control (of which I 
would be most likely to use 0x00 NUL or 0x1b ESC) vs. an intentional use 
of 0xff may need different wording here.

But if you don't want to give 0xff any more special treatment than what 
it already has as a lexical error (and that ALL lexical errors result in 
a stream reset, but possibly after emitting error messages), then this 
wording seems okay.

> +
> +2.7 QGA Synchronization
>   -----------------------
>   
>   When using QGA, an additional synchronization feature is built into
> -the protocol.  If the Client sends a raw 0xFF sentinel byte (not valid
> -JSON), then the Server will reset its state and discard all pending
> -data prior to the sentinel.  Conversely, if the Client makes use of
> -the 'guest-sync-delimited' command, the Server will send a raw 0xFF
> -sentinel byte prior to its response, to aid the Client in discarding
> -any data prior to the sentinel.
> +the protocol. If the Client makes use of the 'guest-sync-delimited'
> +command, the Server will send a raw 0xFF sentinel byte prior to its
> +response, to aid the Client in discarding any data prior to the
> +sentinel.

Maybe worth mentioning "including error messages reported about any 
lexical errors received prior to the guest-sync-delimited command"

>   
>   
>   3. QMP Examples
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
