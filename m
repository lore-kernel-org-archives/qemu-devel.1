Received: from eggs.gnu.org ([2001:4830:134:3::10]:37934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjqRM-0001mc-9B
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjqRH-00027W-DK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:52:24 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjqRH-00027J-5k
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:52:19 -0500
Received: by mail-qk0-x241.google.com with SMTP id j127so10379299qke.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:52:19 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
	<1487248176-29602-2-git-send-email-dmitry@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <954f8f71-4a6e-7e75-3c60-91ffbc322331@amsat.org>
Date: Fri, 3 Mar 2017 13:52:13 -0300
MIME-Version: 1.0
In-Reply-To: <1487248176-29602-2-git-send-email-dmitry@daynix.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/5] eth: Extend vlan stripping functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, P J P <ppandit@redhat.com>

On 02/16/2017 09:29 AM, Dmitry Fleytman wrote:
> Make VLAN stripping functions return number of bytes
> copied to given Ethernet header buffer.
>
> This information should be used to re-compose
> packet IOV after VLAN stripping.
>
> Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
> ---
>  include/net/eth.h |  4 ++--
>  net/eth.c         | 25 ++++++++++++++-----------
>  2 files changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/include/net/eth.h b/include/net/eth.h
> index 2013175..afeb45b 100644
> --- a/include/net/eth.h
> +++ b/include/net/eth.h
> @@ -331,12 +331,12 @@ eth_get_pkt_tci(const void *p)
>      }
>  }
>
> -bool
> +size_t
>  eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
>                 uint8_t *new_ehdr_buf,
>                 uint16_t *payload_offset, uint16_t *tci);
>
> -bool
> +size_t
>  eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
>                    uint16_t vet, uint8_t *new_ehdr_buf,
>                    uint16_t *payload_offset, uint16_t *tci);
> diff --git a/net/eth.c b/net/eth.c
> index df81efb..5b9ba26 100644
> --- a/net/eth.c
> +++ b/net/eth.c
> @@ -232,7 +232,7 @@ void eth_get_protocols(const struct iovec *iov, int iovcnt,
>      }
>  }
>
> -bool
> +size_t
>  eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
>                 uint8_t *new_ehdr_buf,
>                 uint16_t *payload_offset, uint16_t *tci)
> @@ -244,7 +244,7 @@ eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
>                                 new_ehdr, sizeof(*new_ehdr));
>
>      if (copied < sizeof(*new_ehdr)) {
> -        return false;
> +        return 0;
>      }
>
>      switch (be16_to_cpu(new_ehdr->h_proto)) {
> @@ -254,7 +254,7 @@ eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
>                              &vlan_hdr, sizeof(vlan_hdr));
>
>          if (copied < sizeof(vlan_hdr)) {
> -            return false;
> +            return 0;
>          }
>
>          new_ehdr->h_proto = vlan_hdr.h_proto;
> @@ -268,18 +268,21 @@ eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
>                                  PKT_GET_VLAN_HDR(new_ehdr), sizeof(vlan_hdr));
>
>              if (copied < sizeof(vlan_hdr)) {
> -                return false;
> +                return 0;
>              }
>
>              *payload_offset += sizeof(vlan_hdr);
> +
> +            return sizeof(struct eth_header) + sizeof(struct vlan_header);
> +        } else {
> +            return sizeof(struct eth_header);

remove this "else return ..."

>          }
> -        return true;

here avoid fall-through with 'return sizeof(struct eth_header);'

>      default:
> -        return false;
> +        return 0;
>      }
>  }
>
> -bool
> +size_t
>  eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
>                    uint16_t vet, uint8_t *new_ehdr_buf,
>                    uint16_t *payload_offset, uint16_t *tci)
> @@ -291,7 +294,7 @@ eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
>                                 new_ehdr, sizeof(*new_ehdr));
>
>      if (copied < sizeof(*new_ehdr)) {
> -        return false;
> +        return 0;
>      }
>
>      if (be16_to_cpu(new_ehdr->h_proto) == vet) {
> @@ -299,17 +302,17 @@ eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
>                              &vlan_hdr, sizeof(vlan_hdr));
>
>          if (copied < sizeof(vlan_hdr)) {
> -            return false;
> +            return 0;
>          }
>
>          new_ehdr->h_proto = vlan_hdr.h_proto;
>
>          *tci = be16_to_cpu(vlan_hdr.h_tci);
>          *payload_offset = iovoff + sizeof(*new_ehdr) + sizeof(vlan_hdr);
> -        return true;
> +        return sizeof(struct eth_header);
>      }
>
> -    return false;
> +    return 0;
>  }
>
>  void
>

with changes:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Phil.
