Received: from eggs.gnu.org ([2001:4830:134:3::10]:36422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fAzKP-0003Wc-II
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fAzKK-0001yp-Ks
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:53:57 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:56127)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fAzKK-0001xY-CZ
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:53:52 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-ID: <23263.17660.17771.980752@mariner.uk.xensource.com>
Date: Tue, 24 Apr 2018 15:53:48 +0100
In-Reply-To: <b8d20908-c76c-1dc2-2c14-31c185abbbfc@amsat.org>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-16-git-send-email-ian.jackson@eu.citrix.com>
	<b8d20908-c76c-1dc2-2c14-31c185abbbfc@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 15/16] os-posix: cleanup: Replace perror
 with error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Philippe Mathieu-Daudé writes ("Re: [Qemu-devel] [PATCH 15/16] os-posix: cleanup: Replace perror with error_report"):
> On 04/19/2018 01:45 PM, Ian Jackson wrote:
> > -        perror("mlockall");
> > +        error_report("mlockall: %s", strerror(errno));
> >      }
> >  
> >      return ret;
> 
> Thinking loudly, maybe we can refactor as error_report_errno(const char
> *desc)...

git-grep 'error_report.*errno' shows a lot of call sites that do
something more exciting than const char *desc would support.

I think the right approach would be

 - static void vreport(report_type type, const char *fmt, va_list ap)
 + static void vreport(report_type type, int errnoval, const char *fmt, va_list ap)
...
 +     if (errnoval >= 0) {
 +         error_printf(": %s", strerror(errnoval);
 +     }

and then add both
  error_report_errno
  error_vreport_errno
with the obvious semantics.

Ian.
