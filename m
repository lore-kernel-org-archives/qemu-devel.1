Received: from eggs.gnu.org ([2001:4830:134:3::10]:34975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eEZam-0002fx-5Z
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 06:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eEZaj-0001Q0-0B
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 06:41:24 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1510658424-16527-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <48c29785-90a5-f479-9090-9de616d112f5@amsat.org>
Date: Tue, 14 Nov 2017 08:41:04 -0300
MIME-Version: 1.0
In-Reply-To: <1510658424-16527-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11] hw/net/vmxnet3: Fix code to
 work on big endian hosts, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Dmitry Fleytman <dmitry@daynix.com>, David Gibson <dgibson@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On 11/14/2017 08:20 AM, Thomas Huth wrote:
> Since commit ab06ec43577177a442e8 we test the vmxnet3 device in the
> pxe-tester, too (when running "make check SPEED=slow"). This now
> revealed that the code is not working there if the host is a big
> endian machine (for example ppc64 or s390x) - "make check SPEED=slow"
> is now failing on such hosts.
> 
> The vmxnet3 code lacks endianess conversions in a couple of places.

endianness

> Interestingly, the bitfields in the structs in vmxnet3.h already tried to
> take care of the *bit* endianess of the C compilers - but the code missed

ditto

> to change the *byte* endianess when reading or writing the corresponding
> structs. So the bitfields are now wrapped into unions which allow to change
> the byte endianess during runtime with the non-bitfield member of the union.
> With these changes, "make check SPEED=slow" now properly works on big endian
> hosts, too.
> 
> Reported-by: David Gibson <dgibson@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Introduced vmxnet3_ring_read_curr_txdesc() & vmxnet3_pci_dma_write_rxcd()
>    helper functions to wrap the byte-swapping code that is required in
>    multiple places (as suggested by Philippe)

Thanks for this, probably matter of taste but it looks nicer now :)

If the maintainer can fix the "endianness" typo:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
>  hw/net/vmware_utils.h |   6 ++
>  hw/net/vmxnet3.c      |  46 +++++++---
>  hw/net/vmxnet3.h      | 230 ++++++++++++++++++++++++++++++--------------------
>  3 files changed, 181 insertions(+), 101 deletions(-)
> 
> diff --git a/hw/net/vmware_utils.h b/hw/net/vmware_utils.h
> index 5500601..6b1e251 100644
> --- a/hw/net/vmware_utils.h
> +++ b/hw/net/vmware_utils.h
> @@ -83,6 +83,7 @@ vmw_shmem_ld16(PCIDevice *d, hwaddr addr)
>  {
>      uint16_t res;
>      pci_dma_read(d, addr, &res, 2);
> +    res = le16_to_cpu(res);
>      VMW_SHPRN("SHMEM load16: %" PRIx64 " (value 0x%X)", addr, res);
>      return res;
>  }
> @@ -91,6 +92,7 @@ static inline void
>  vmw_shmem_st16(PCIDevice *d, hwaddr addr, uint16_t value)
>  {
>      VMW_SHPRN("SHMEM store16: %" PRIx64 " (value 0x%X)", addr, value);
> +    value = cpu_to_le16(value);
>      pci_dma_write(d, addr, &value, 2);
>  }
>  
> @@ -99,6 +101,7 @@ vmw_shmem_ld32(PCIDevice *d, hwaddr addr)
>  {
>      uint32_t res;
>      pci_dma_read(d, addr, &res, 4);
> +    res = le32_to_cpu(res);
>      VMW_SHPRN("SHMEM load32: %" PRIx64 " (value 0x%X)", addr, res);
>      return res;
>  }
> @@ -107,6 +110,7 @@ static inline void
>  vmw_shmem_st32(PCIDevice *d, hwaddr addr, uint32_t value)
>  {
>      VMW_SHPRN("SHMEM store32: %" PRIx64 " (value 0x%X)", addr, value);
> +    value = cpu_to_le32(value);
>      pci_dma_write(d, addr, &value, 4);
>  }
>  
> @@ -115,6 +119,7 @@ vmw_shmem_ld64(PCIDevice *d, hwaddr addr)
>  {
>      uint64_t res;
>      pci_dma_read(d, addr, &res, 8);
> +    res = le64_to_cpu(res);
>      VMW_SHPRN("SHMEM load64: %" PRIx64 " (value %" PRIx64 ")", addr, res);
>      return res;
>  }
> @@ -123,6 +128,7 @@ static inline void
>  vmw_shmem_st64(PCIDevice *d, hwaddr addr, uint64_t value)
>  {
>      VMW_SHPRN("SHMEM store64: %" PRIx64 " (value %" PRIx64 ")", addr, value);
> +    value = cpu_to_le64(value);
>      pci_dma_write(d, addr, &value, 8);
>  }
>  
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 8c4bae5..bfb066a 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -222,7 +222,7 @@ vmxnet3_dump_tx_descr(struct Vmxnet3_TxDesc *descr)
>                "addr %" PRIx64 ", len: %d, gen: %d, rsvd: %d, "
>                "dtype: %d, ext1: %d, msscof: %d, hlen: %d, om: %d, "
>                "eop: %d, cq: %d, ext2: %d, ti: %d, tci: %d",
> -              le64_to_cpu(descr->addr), descr->len, descr->gen, descr->rsvd,
> +              descr->addr, descr->len, descr->gen, descr->rsvd,
>                descr->dtype, descr->ext1, descr->msscof, descr->hlen, descr->om,
>                descr->eop, descr->cq, descr->ext2, descr->ti, descr->tci);
>  }
> @@ -241,7 +241,7 @@ vmxnet3_dump_rx_descr(struct Vmxnet3_RxDesc *descr)
>  {
>      VMW_PKPRN("RX DESCR: addr %" PRIx64 ", len: %d, gen: %d, rsvd: %d, "
>                "dtype: %d, ext1: %d, btype: %d",
> -              le64_to_cpu(descr->addr), descr->len, descr->gen,
> +              descr->addr, descr->len, descr->gen,
>                descr->rsvd, descr->dtype, descr->ext1, descr->btype);
>  }
>  
> @@ -535,7 +535,8 @@ static void vmxnet3_complete_packet(VMXNET3State *s, int qidx, uint32_t tx_ridx)
>      memset(&txcq_descr, 0, sizeof(txcq_descr));
>      txcq_descr.txdIdx = tx_ridx;
>      txcq_descr.gen = vmxnet3_ring_curr_gen(&s->txq_descr[qidx].comp_ring);
> -
> +    txcq_descr.val1 = cpu_to_le32(txcq_descr.val1);
> +    txcq_descr.val2 = cpu_to_le32(txcq_descr.val2);
>      vmxnet3_ring_write_curr_cell(d, &s->txq_descr[qidx].comp_ring, &txcq_descr);
>  
>      /* Flush changes in TX descriptor before changing the counter value */
> @@ -685,6 +686,16 @@ vmxnet3_on_rx_done_update_stats(VMXNET3State *s,
>      }
>  }
>  
> +static inline void
> +vmxnet3_ring_read_curr_txdesc(PCIDevice *pcidev, Vmxnet3Ring *ring,
> +                              struct Vmxnet3_TxDesc *txd)
> +{
> +    vmxnet3_ring_read_curr_cell(pcidev, ring, txd);
> +    txd->addr = le64_to_cpu(txd->addr);
> +    txd->val1 = le32_to_cpu(txd->val1);
> +    txd->val2 = le32_to_cpu(txd->val2);
> +}
> +
>  static inline bool
>  vmxnet3_pop_next_tx_descr(VMXNET3State *s,
>                            int qidx,
> @@ -694,12 +705,12 @@ vmxnet3_pop_next_tx_descr(VMXNET3State *s,
>      Vmxnet3Ring *ring = &s->txq_descr[qidx].tx_ring;
>      PCIDevice *d = PCI_DEVICE(s);
>  
> -    vmxnet3_ring_read_curr_cell(d, ring, txd);
> +    vmxnet3_ring_read_curr_txdesc(d, ring, txd);
>      if (txd->gen == vmxnet3_ring_curr_gen(ring)) {
>          /* Only read after generation field verification */
>          smp_rmb();
>          /* Re-read to be sure we got the latest version */
> -        vmxnet3_ring_read_curr_cell(d, ring, txd);
> +        vmxnet3_ring_read_curr_txdesc(d, ring, txd);
>          VMXNET3_RING_DUMP(VMW_RIPRN, "TX", qidx, ring);
>          *descr_idx = vmxnet3_ring_curr_cell_idx(ring);
>          vmxnet3_inc_tx_consumption_counter(s, qidx);
> @@ -749,7 +760,7 @@ static void vmxnet3_process_tx_queue(VMXNET3State *s, int qidx)
>  
>          if (!s->skip_current_tx_pkt) {
>              data_len = (txd.len > 0) ? txd.len : VMXNET3_MAX_TX_BUF_SIZE;
> -            data_pa = le64_to_cpu(txd.addr);
> +            data_pa = txd.addr;
>  
>              if (!net_tx_pkt_add_raw_fragment(s->tx_pkt,
>                                                  data_pa,
> @@ -792,6 +803,9 @@ vmxnet3_read_next_rx_descr(VMXNET3State *s, int qidx, int ridx,
>      Vmxnet3Ring *ring = &s->rxq_descr[qidx].rx_ring[ridx];
>      *didx = vmxnet3_ring_curr_cell_idx(ring);
>      vmxnet3_ring_read_curr_cell(d, ring, dbuf);
> +    dbuf->addr = le64_to_cpu(dbuf->addr);
> +    dbuf->val1 = le32_to_cpu(dbuf->val1);
> +    dbuf->ext1 = le32_to_cpu(dbuf->ext1);
>  }
>  
>  static inline uint8_t
> @@ -811,6 +825,9 @@ vmxnet3_pop_rxc_descr(VMXNET3State *s, int qidx, uint32_t *descr_gen)
>  
>      pci_dma_read(PCI_DEVICE(s),
>                   daddr, &rxcd, sizeof(struct Vmxnet3_RxCompDesc));
> +    rxcd.val1 = le32_to_cpu(rxcd.val1);
> +    rxcd.val2 = le32_to_cpu(rxcd.val2);
> +    rxcd.val3 = le32_to_cpu(rxcd.val3);
>      ring_gen = vmxnet3_ring_curr_gen(&s->rxq_descr[qidx].comp_ring);
>  
>      if (rxcd.gen != ring_gen) {
> @@ -1060,6 +1077,16 @@ vmxnet3_pci_dma_writev(PCIDevice *pci_dev,
>      }
>  }
>  
> +static void
> +vmxnet3_pci_dma_write_rxcd(PCIDevice *pcidev, dma_addr_t pa,
> +                           struct Vmxnet3_RxCompDesc *rxcd)
> +{
> +    rxcd->val1 = cpu_to_le32(rxcd->val1);
> +    rxcd->val2 = cpu_to_le32(rxcd->val2);
> +    rxcd->val3 = cpu_to_le32(rxcd->val3);
> +    pci_dma_write(pcidev, pa, rxcd, sizeof(*rxcd));
> +}
> +
>  static bool
>  vmxnet3_indicate_packet(VMXNET3State *s)
>  {
> @@ -1098,15 +1125,14 @@ vmxnet3_indicate_packet(VMXNET3State *s)
>          }
>  
>          chunk_size = MIN(bytes_left, rxd.len);
> -        vmxnet3_pci_dma_writev(d, data, bytes_copied,
> -                               le64_to_cpu(rxd.addr), chunk_size);
> +        vmxnet3_pci_dma_writev(d, data, bytes_copied, rxd.addr, chunk_size);
>          bytes_copied += chunk_size;
>          bytes_left -= chunk_size;
>  
>          vmxnet3_dump_rx_descr(&rxd);
>  
>          if (ready_rxcd_pa != 0) {
> -            pci_dma_write(d, ready_rxcd_pa, &rxcd, sizeof(rxcd));
> +            vmxnet3_pci_dma_write_rxcd(d, ready_rxcd_pa, &rxcd);
>          }
>  
>          memset(&rxcd, 0, sizeof(struct Vmxnet3_RxCompDesc));
> @@ -1138,7 +1164,7 @@ vmxnet3_indicate_packet(VMXNET3State *s)
>          rxcd.eop = 1;
>          rxcd.err = (bytes_left != 0);
>  
> -        pci_dma_write(d, ready_rxcd_pa, &rxcd, sizeof(rxcd));
> +        vmxnet3_pci_dma_write_rxcd(d, ready_rxcd_pa, &rxcd);
>  
>          /* Flush RX descriptor changes */
>          smp_wmb();
> diff --git a/hw/net/vmxnet3.h b/hw/net/vmxnet3.h
> index f9352c4..5b3b76b 100644
> --- a/hw/net/vmxnet3.h
> +++ b/hw/net/vmxnet3.h
> @@ -226,39 +226,49 @@ enum {
>  struct Vmxnet3_TxDesc {
>      __le64 addr;
>  
> +    union {
> +        struct {
>  #ifdef __BIG_ENDIAN_BITFIELD
> -    u32 msscof:14;  /* MSS, checksum offset, flags */
> -    u32 ext1:1;
> -    u32 dtype:1;    /* descriptor type */
> -    u32 rsvd:1;
> -    u32 gen:1;      /* generation bit */
> -    u32 len:14;
> +            u32 msscof:14;  /* MSS, checksum offset, flags */
> +            u32 ext1:1;
> +            u32 dtype:1;    /* descriptor type */
> +            u32 rsvd:1;
> +            u32 gen:1;      /* generation bit */
> +            u32 len:14;
>  #else
> -    u32 len:14;
> -    u32 gen:1;      /* generation bit */
> -    u32 rsvd:1;
> -    u32 dtype:1;    /* descriptor type */
> -    u32 ext1:1;
> -    u32 msscof:14;  /* MSS, checksum offset, flags */
> +            u32 len:14;
> +            u32 gen:1;      /* generation bit */
> +            u32 rsvd:1;
> +            u32 dtype:1;    /* descriptor type */
> +            u32 ext1:1;
> +            u32 msscof:14;  /* MSS, checksum offset, flags */
>  #endif  /* __BIG_ENDIAN_BITFIELD */
> -
> +        };
> +        u32 val1;
> +    };
> +    
> +    union {
> +        struct {
>  #ifdef __BIG_ENDIAN_BITFIELD
> -    u32 tci:16;     /* Tag to Insert */
> -    u32 ti:1;       /* VLAN Tag Insertion */
> -    u32 ext2:1;
> -    u32 cq:1;       /* completion request */
> -    u32 eop:1;      /* End Of Packet */
> -    u32 om:2;       /* offload mode */
> -    u32 hlen:10;    /* header len */
> +            u32 tci:16;     /* Tag to Insert */
> +            u32 ti:1;       /* VLAN Tag Insertion */
> +            u32 ext2:1;
> +            u32 cq:1;       /* completion request */
> +            u32 eop:1;      /* End Of Packet */
> +            u32 om:2;       /* offload mode */
> +            u32 hlen:10;    /* header len */
>  #else
> -    u32 hlen:10;    /* header len */
> -    u32 om:2;       /* offload mode */
> -    u32 eop:1;      /* End Of Packet */
> -    u32 cq:1;       /* completion request */
> -    u32 ext2:1;
> -    u32 ti:1;       /* VLAN Tag Insertion */
> -    u32 tci:16;     /* Tag to Insert */
> +            u32 hlen:10;    /* header len */
> +            u32 om:2;       /* offload mode */
> +            u32 eop:1;      /* End Of Packet */
> +            u32 cq:1;       /* completion request */
> +            u32 ext2:1;
> +            u32 ti:1;       /* VLAN Tag Insertion */
> +            u32 tci:16;     /* Tag to Insert */
>  #endif  /* __BIG_ENDIAN_BITFIELD */
> +        };
> +        u32 val2;
> +    };
>  };
>  
>  /* TxDesc.OM values */
> @@ -291,33 +301,57 @@ struct Vmxnet3_TxDataDesc {
>  #define VMXNET3_TCD_GEN_DWORD_SHIFT    3
>  
>  struct Vmxnet3_TxCompDesc {
> -    u32        txdIdx:12;    /* Index of the EOP TxDesc */
> -    u32        ext1:20;
> -
> +    union {
> +        struct {
> +#ifdef __BIG_ENDIAN_BITFIELD
> +            u32 ext1:20;
> +            u32 txdIdx:12;    /* Index of the EOP TxDesc */
> +#else
> +            u32 txdIdx:12;    /* Index of the EOP TxDesc */
> +            u32 ext1:20;
> +#endif
> +        };
> +        u32 val1;
> +    };
>      __le32        ext2;
>      __le32        ext3;
>  
> -    u32        rsvd:24;
> -    u32        type:7;       /* completion type */
> -    u32        gen:1;        /* generation bit */
> +    union {
> +        struct {
> +#ifdef __BIG_ENDIAN_BITFIELD
> +            u32 gen:1;        /* generation bit */
> +            u32 type:7;       /* completion type */
> +            u32 rsvd:24;
> +#else
> +            u32 rsvd:24;
> +            u32 type:7;       /* completion type */
> +            u32 gen:1;        /* generation bit */
> +#endif
> +        };
> +        u32 val2;
> +    };
>  };
>  
>  struct Vmxnet3_RxDesc {
>      __le64        addr;
> -
> +    union {
> +        struct {
>  #ifdef __BIG_ENDIAN_BITFIELD
> -    u32        gen:1;        /* Generation bit */
> -    u32        rsvd:15;
> -    u32        dtype:1;      /* Descriptor type */
> -    u32        btype:1;      /* Buffer Type */
> -    u32        len:14;
> +            u32 gen:1;        /* Generation bit */
> +            u32 rsvd:15;
> +            u32 dtype:1;      /* Descriptor type */
> +            u32 btype:1;      /* Buffer Type */
> +            u32 len:14;
>  #else
> -    u32        len:14;
> -    u32        btype:1;      /* Buffer Type */
> -    u32        dtype:1;      /* Descriptor type */
> -    u32        rsvd:15;
> -    u32        gen:1;        /* Generation bit */
> +            u32 len:14;
> +            u32 btype:1;      /* Buffer Type */
> +            u32 dtype:1;      /* Descriptor type */
> +            u32 rsvd:15;
> +            u32 gen:1;        /* Generation bit */
>  #endif
> +        };
> +        u32 val1;
> +    };
>      u32        ext1;
>  };
>  
> @@ -330,66 +364,80 @@ struct Vmxnet3_RxDesc {
>  #define VMXNET3_RXD_GEN_SHIFT    31
>  
>  struct Vmxnet3_RxCompDesc {
> +    union {
> +        struct {
>  #ifdef __BIG_ENDIAN_BITFIELD
> -    u32        ext2:1;
> -    u32        cnc:1;        /* Checksum Not Calculated */
> -    u32        rssType:4;    /* RSS hash type used */
> -    u32        rqID:10;      /* rx queue/ring ID */
> -    u32        sop:1;        /* Start of Packet */
> -    u32        eop:1;        /* End of Packet */
> -    u32        ext1:2;
> -    u32        rxdIdx:12;    /* Index of the RxDesc */
> +            u32 ext2:1;
> +            u32 cnc:1;        /* Checksum Not Calculated */
> +            u32 rssType:4;    /* RSS hash type used */
> +            u32 rqID:10;      /* rx queue/ring ID */
> +            u32 sop:1;        /* Start of Packet */
> +            u32 eop:1;        /* End of Packet */
> +            u32 ext1:2;
> +            u32 rxdIdx:12;    /* Index of the RxDesc */
>  #else
> -    u32        rxdIdx:12;    /* Index of the RxDesc */
> -    u32        ext1:2;
> -    u32        eop:1;        /* End of Packet */
> -    u32        sop:1;        /* Start of Packet */
> -    u32        rqID:10;      /* rx queue/ring ID */
> -    u32        rssType:4;    /* RSS hash type used */
> -    u32        cnc:1;        /* Checksum Not Calculated */
> -    u32        ext2:1;
> +            u32 rxdIdx:12;    /* Index of the RxDesc */
> +            u32 ext1:2;
> +            u32 eop:1;        /* End of Packet */
> +            u32 sop:1;        /* Start of Packet */
> +            u32 rqID:10;      /* rx queue/ring ID */
> +            u32 rssType:4;    /* RSS hash type used */
> +            u32 cnc:1;        /* Checksum Not Calculated */
> +            u32 ext2:1;
>  #endif  /* __BIG_ENDIAN_BITFIELD */
> +        };
> +        u32 val1;
> +    };
>  
>      __le32        rssHash;      /* RSS hash value */
>  
> +    union {
> +        struct {
>  #ifdef __BIG_ENDIAN_BITFIELD
> -    u32        tci:16;       /* Tag stripped */
> -    u32        ts:1;         /* Tag is stripped */
> -    u32        err:1;        /* Error */
> -    u32        len:14;       /* data length */
> +            u32 tci:16;       /* Tag stripped */
> +            u32 ts:1;         /* Tag is stripped */
> +            u32 err:1;        /* Error */
> +            u32 len:14;       /* data length */
>  #else
> -    u32        len:14;       /* data length */
> -    u32        err:1;        /* Error */
> -    u32        ts:1;         /* Tag is stripped */
> -    u32        tci:16;       /* Tag stripped */
> +            u32 len:14;       /* data length */
> +            u32 err:1;        /* Error */
> +            u32 ts:1;         /* Tag is stripped */
> +            u32 tci:16;       /* Tag stripped */
>  #endif  /* __BIG_ENDIAN_BITFIELD */
> +        };
> +        u32 val2;
> +    };
>  
> -
> +    union {
> +        struct {
>  #ifdef __BIG_ENDIAN_BITFIELD
> -    u32        gen:1;        /* generation bit */
> -    u32        type:7;       /* completion type */
> -    u32        fcs:1;        /* Frame CRC correct */
> -    u32        frg:1;        /* IP Fragment */
> -    u32        v4:1;         /* IPv4 */
> -    u32        v6:1;         /* IPv6 */
> -    u32        ipc:1;        /* IP Checksum Correct */
> -    u32        tcp:1;        /* TCP packet */
> -    u32        udp:1;        /* UDP packet */
> -    u32        tuc:1;        /* TCP/UDP Checksum Correct */
> -    u32        csum:16;
> +            u32 gen:1;        /* generation bit */
> +            u32 type:7;       /* completion type */
> +            u32 fcs:1;        /* Frame CRC correct */
> +            u32 frg:1;        /* IP Fragment */
> +            u32 v4:1;         /* IPv4 */
> +            u32 v6:1;         /* IPv6 */
> +            u32 ipc:1;        /* IP Checksum Correct */
> +            u32 tcp:1;        /* TCP packet */
> +            u32 udp:1;        /* UDP packet */
> +            u32 tuc:1;        /* TCP/UDP Checksum Correct */
> +            u32 csum:16;
>  #else
> -    u32        csum:16;
> -    u32        tuc:1;        /* TCP/UDP Checksum Correct */
> -    u32        udp:1;        /* UDP packet */
> -    u32        tcp:1;        /* TCP packet */
> -    u32        ipc:1;        /* IP Checksum Correct */
> -    u32        v6:1;         /* IPv6 */
> -    u32        v4:1;         /* IPv4 */
> -    u32        frg:1;        /* IP Fragment */
> -    u32        fcs:1;        /* Frame CRC correct */
> -    u32        type:7;       /* completion type */
> -    u32        gen:1;        /* generation bit */
> +            u32 csum:16;
> +            u32 tuc:1;        /* TCP/UDP Checksum Correct */
> +            u32 udp:1;        /* UDP packet */
> +            u32 tcp:1;        /* TCP packet */
> +            u32 ipc:1;        /* IP Checksum Correct */
> +            u32 v6:1;         /* IPv6 */
> +            u32 v4:1;         /* IPv4 */
> +            u32 frg:1;        /* IP Fragment */
> +            u32 fcs:1;        /* Frame CRC correct */
> +            u32 type:7;       /* completion type */
> +            u32 gen:1;        /* generation bit */
>  #endif  /* __BIG_ENDIAN_BITFIELD */
> +        };
> +        u32 val3;
> +    };
>  };
>  
>  /* fields in RxCompDesc we access via Vmxnet3_GenericDesc.dword[3] */
> 
