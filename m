Received: from eggs.gnu.org ([2001:4830:134:3::10]:46773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0r8j-00053Y-1t
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0r8g-0004lh-9y
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:08:01 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f0r8g-0004jt-4F
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:07:58 -0400
Received: by mail-wr0-f195.google.com with SMTP id p53so15437588wrc.10
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 09:07:57 -0700 (PDT)
References: <20180327113452.19613-1-dgilbert@redhat.com>
	<20180327113452.19613-4-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0bfadead-a3c2-9bce-3e53-8ca3a258a57a@redhat.com>
Date: Tue, 27 Mar 2018 18:07:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180327113452.19613-4-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] e1000: Old machine types,
 turn new subsection off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, eswierk@skyportsystems.com, jasowang@redhat.com
Cc: peterx@redhat.com, quintela@redhat.com

On 27/03/2018 13:34, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Turn the newly added subsection off for old machine types
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  include/hw/compat.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index bc9e3a6627..13242b831a 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -14,6 +14,10 @@
>          .driver   = "vhost-user-blk-pci",\
>          .property = "vectors",\
>          .value    = "2",\
> +    },{\
> +        .driver   = "e1000",\
> +        .property = "migrate_tso_props",\
> +        .value    = "off",\
>      },
>  
>  #define HW_COMPAT_2_10 \
> 

Unfortunately it's not that easy, because on old machine types
tx.tso_props was stored in tx.props.  So if the subsection is absent you
have to migrate either tx.tso_props or tx.props, depending on s->tx.cptse.

Likewise if you migrate from older versions: if s->tx.props.tse &&
s->tx.cptse, you have to copy s->tx.props to s->tx.tso_props and clear
s->tx.props.  My understanding is that s->tx.tso_props.tse will be 1 if
and only if the source sent s->tx.tso_props.

This seems most easily done with a new field (e.g. vmstate_fixed_props)
that is written in pre_save and set in post_load.

Paolo
