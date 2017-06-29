Received: from eggs.gnu.org ([2001:4830:134:3::10]:53427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQZfx-0000Ka-O1
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:40:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQZfu-0000Em-Lf
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:40:05 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dQZfu-0000EG-F3
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:40:02 -0400
Received: by mail-wr0-f172.google.com with SMTP id k67so189130078wrc.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 06:40:02 -0700 (PDT)
References: <20170613165313.20954-1-ehabkost@redhat.com>
	<87o9t8qy7d.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6fac3c3d-9cf8-cb79-0141-908fe8160a5b@redhat.com>
Date: Thu, 29 Jun 2017 15:39:58 +0200
MIME-Version: 1.0
In-Reply-To: <87o9t8qy7d.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 00/15] Error API: Flag errors in *errp even
 if errors are being ignored
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On 28/06/2017 11:05, Markus Armbruster wrote:
> If foo() additionally returned an indication of success, you could write
> 
>       if (!foo(arg, errp)) {    // assuming foo() returns a bool
>           handle the error...
>       }
> 
> Nicely concise.
> 
> For what it's worth, this is how GLib wants GError to be used.  We
> deviated from it, and it has turned out to be a self-inflicted wound.
> 

I find Eduardo's proposal better.  With GLib's way it's easy to confuse
functions that return 0/-1, 0/-errno, TRUE/FALSE, FALSE/TRUE or
NULL/non-NULL.

Declaring and testing local_err doesn't introduce much boilerplate, it's
propagation to errp that does.  The disadvantage of Eduardo's mechanism
is that it produces slightly worse code, but Error** is rarely used in
hot code.  It could also be improved slightly by changing
ignored_error_unset and ignored_error_set to a 2-element array.

Paolo
