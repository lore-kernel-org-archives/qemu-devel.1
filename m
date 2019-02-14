Received: from eggs.gnu.org ([209.51.188.92]:36959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDib-0004RR-Uh
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDia-0008RK-Jl
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:54:09 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190212134758.10514-1-dgilbert@redhat.com>
	<20190212134758.10514-3-dgilbert@redhat.com>
Date: Thu, 14 Feb 2019 10:53:58 +0100
In-Reply-To: <20190212134758.10514-3-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Tue, 12 Feb 2019 13:47:56 +0000")
Message-ID: <87o97eae6h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/4] HMP: Prepend errors with 'Error:'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com, mst@redhat.com, qemu-trivial@nongnu.org

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Always make error messages start with 'Error:' as a fallback
> to make sure that anything parsing them can tell it failed.

Feeding HMP output to programs is a bad idea to begin with.  

> Note: Some places don't use hmp_handle_error

True.  A more honest subject would be "HMP: Prepend some errors with
'Error:'".

Several distinct reasons for not using hmp_handle_error():

* Handling an error that isn't transmitted as an Error object

  HMP command handlers generally wrap around QMP command handlers, which
  always use Error objects.  Still, there are other sources of errors
  when the HMP command does more than the wrapped QMP command (typically
  convenience features for humans), or there is no wrapped QMP command.

* Augmenting the error message

  Reporting with error_reportf_err() is easier than first messing with
  the Error object, then passing it to hmp_handle_error().  Example:
  hmp_delvm().

* hmp_handle_error() is static, and we're outside hmp.c

  Tolerable as long as hmp_handle_error() is trivial.  Your patch makes
  it a bit less trivial.

If we truly want to "Prepend errors with 'Error:'", then we should make
hmp command handlers take an Error ** argument, and leave the reporting
to the HMP core.

If you think prepending some errors is useful (and I guess you do), go
right ahead with this patch.  I'd recommend to use the more honest
subject, though.
