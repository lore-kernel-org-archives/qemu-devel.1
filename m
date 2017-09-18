Received: from eggs.gnu.org ([2001:4830:134:3::10]:53238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtx6t-0001pY-H1
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtx6n-0002d0-Qc
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:33:19 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:50638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dtx6n-0002cc-KD
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:33:13 -0400
Received: by mail-wr0-x22e.google.com with SMTP id w12so662293wrc.7
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 07:33:13 -0700 (PDT)
Date: Mon, 18 Sep 2017 15:33:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170918143308.GA4141@stefanha-x1.localdomain>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<150529666493.10902.14830445134051381968.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <150529666493.10902.14830445134051381968.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Sep 13, 2017 at 12:57:45PM +0300, Lluís Vilanova wrote:
> +    /* mandatory initialization function */
> +    int main(int argc, const char **argv)

Most shared library plugin interfaces I have seen do not use "main()" as
the entry point.  Instead they use a unique name that allows the host
application to differentiate between share library files that are valid
plugins (e.g. "qemu_instr_init") and non-plugin shared libraries.

Stable plugin APIs usually have a versioning or feature detection
scheme.  Versioning is simple: the host application passes a major/minor
version number to the init function.

Of course the dynamic linker already enforces compatibility somewhat: if
a plugin uses a newer API than available in the host application then
there will be a missing symbol/linker error.

So what versioning strategy should we follow?  The simplest would be to
depend 100% on the dynamic linker with no explicit checks inside the
plugin or QEMU.  In that case the API/ABI need to follow some rules like
this (not sure how oudated this information is):
http://plan99.net/~mike/writing-shared-libraries.html

> +    {
> +        int i;
> +        printf("init!\n");
> +        printf("    argc :: %d\n", argc);
> +        for (i = 0; i < argc; i++) {
> +            printf("            -> %s\n", argv[i]);
> +        }
> +    
> +        qi_set_fini(fini, NULL);
> +    
> +        /* instrument and trace events */
> +        QITraceEvent *ev;
> +    
> +        qi_event_set_guest_cpu_enter(guest_cpu_enter);
> +        ev = qi_trace_event_name("guest_cpu_enter");
> +        assert(ev);
> +        qi_trace_event_set_state_dynamic(ev, true);
> +    
> +        qi_event_set_guest_mem_before_trans(guest_mem_before_trans);
> +        ev = qi_trace_event_name("guest_mem_before_trans");
> +        assert(ev);
> +        qi_trace_event_set_state_dynamic(ev, true);
> +    
> +        qi_event_set_guest_mem_before_exec(guest_mem_before_exec);
> +        ev = qi_trace_event_name("guest_mem_before_exec");
> +        assert(ev);
> +        qi_trace_event_set_state_dynamic(ev, true);

Why are trace events being enabled in this example?

I would expect qi_event_set_guest_cpu_enter(guest_cpu_enter) to
immediately enable the callback.  The user shouldn't need to use tracing
to receive callbacks.

qi_event_set_guest_cpu_enter(NULL) should disable the callback.

Stefan
