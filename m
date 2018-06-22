Received: from eggs.gnu.org ([2001:4830:134:3::10]:37730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fWQte-0000CC-Ff
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fWQtb-000208-9g
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:34:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fWQtb-0001zx-4G
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:34:55 -0400
Date: Fri, 22 Jun 2018 15:34:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180622183448.GB7451@localhost.localdomain>
References: <20180622003140.164613-1-mst@redhat.com>
	<20180622003140.164613-2-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622003140.164613-2-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] kvm: support -overcommit
 cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org

On Fri, Jun 22, 2018 at 03:31:48AM +0300, Michael S. Tsirkin wrote:
[...]
> -                enable_mlock = qemu_opt_get_bool(opts, "mlock", true);
> +                /* Don't override the -dedicated option if set */
> +                enable_mlock = enable_mlock ||
> +                    qemu_opt_get_bool(opts, "mlock", true);
> +                break;
> +            case QEMU_OPTION_dedicated:
> +                opts = qemu_opts_parse_noisily(qemu_find_opts("dedicated"),
> +                                               optarg, false);
> +                if (!opts) {
> +                    exit(1);
> +                }
> +                /* Don't override the -realtime option if set */
> +                enable_mlock = enable_mlock ||
> +                    qemu_opt_get_bool(opts, "mem-lock", false);
> +                enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", false);

I would prefer to simply make the last option win, because it
would be more obvious.  But not a big deal if we are going to
deprecate -realtime.

BTW, are you going to send a qemu-doc.texi patch documenting
-realtime as deprecated?

-- 
Eduardo
