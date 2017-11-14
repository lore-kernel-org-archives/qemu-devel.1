Received: from eggs.gnu.org ([2001:4830:134:3::10]:43041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEWTg-0004Se-TX
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEWTd-0001VO-Ll
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:21:52 -0500
References: <1510592277-20635-1-git-send-email-thuth@redhat.com>
	<4bb42004-19d2-26e5-8ae5-3b873f2b8ec3@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ebe7240c-b349-2f58-ab30-870bf49c2549@redhat.com>
Date: Tue, 14 Nov 2017 09:21:41 +0100
MIME-Version: 1.0
In-Reply-To: <4bb42004-19d2-26e5-8ae5-3b873f2b8ec3@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/net/vmxnet3: Fix code to work
 on big endian hosts, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Dmitry Fleytman <dmitry@daynix.com>, David Gibson <dgibson@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org

On 13.11.2017 23:38, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 11/13/2017 01:57 PM, Thomas Huth wrote:
>> Since commit ab06ec43577177a442e8 we test the vmxnet3 device in the
>> pxe-tester, too (when running "make check SPEED=3Dslow"). This now
>> revealed that the vmxnet3 code is not working right if the host is a b=
ig
>> endian machine (for example ppc64 or s390x) - "make check SPEED=3Dslow=
"
>> is now failing on such hosts.
>>
>> The vmxnet3 code lacks endianess conversions in a couple of places.
>> Interestingly, the bitfields in the structs in vmxnet3.h already tried=
 to
>> take care of the *bit* endianess of the C compilers - but the code mis=
sed
>> to change the *byte* endianess when reading or writing the correspondi=
ng
>> structs. So the bitfields are now wrapped into unions which allow to c=
hange
>> the byte endianess during runtime with the non-bitfield member of the =
union.
>> With these changes, "make check SPEED=3Dslow" now properly works on bi=
g endian
>> hosts, too.
>>
>> Reported-by: David Gibson <dgibson@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
[...]
>> =20
>> @@ -535,7 +535,8 @@ static void vmxnet3_complete_packet(VMXNET3State *=
s, int qidx, uint32_t tx_ridx)
>>      memset(&txcq_descr, 0, sizeof(txcq_descr));
>>      txcq_descr.txdIdx =3D tx_ridx;
>>      txcq_descr.gen =3D vmxnet3_ring_curr_gen(&s->txq_descr[qidx].comp=
_ring);
>> -
>> +    txcq_descr.val1 =3D cpu_to_le32(txcq_descr.val1);
>> +    txcq_descr.val2 =3D cpu_to_le32(txcq_descr.val2);
>>      vmxnet3_ring_write_curr_cell(d, &s->txq_descr[qidx].comp_ring, &t=
xcq_descr);
>=20
> What about using inline functions:
>=20
> - vmxnet3_rxdesc_pci_to_cpu(struct Vmxnet3_RxDesc *rxd)
> - vmxnet3_txdesc_pci_to_cpu(...)
> - vmxnet3_rxcompdesc_pci_to_cpu(struct Vmxnet3_RxCompDesc *rxcd)
> - vmxnet3_txcompdesc_pci_to_cpu(...)

Most of the structure byte-swapping is only done in one place for each
type of structure, so for adding these two or three new lines to the
code, it's not really justified to put them into separate functions that
add at least six or seven new lines of code. This is only useful if the
same struct is byte-swapped at two or more places in the code.

>>      /* Flush changes in TX descriptor before changing the counter val=
ue */
>> @@ -695,11 +696,17 @@ vmxnet3_pop_next_tx_descr(VMXNET3State *s,
>>      PCIDevice *d =3D PCI_DEVICE(s);
>> =20
>>      vmxnet3_ring_read_curr_cell(d, ring, txd);
>> +    txd->addr =3D le64_to_cpu(txd->addr);
>> +    txd->val1 =3D le32_to_cpu(txd->val1);
>> +    txd->val2 =3D le32_to_cpu(txd->val2);
>=20
> ^ probably not useful

At least the txd->gen (via val1) is required one line below! ... and I
wanted to be sure that the caller of vmxnet3_pop_next_tx_descr() always
gets a consistent descriptor, even if the function returns false, so
let's better be safe than sorry and always swap all fields of the struct.

>>      if (txd->gen =3D=3D vmxnet3_ring_curr_gen(ring)) {
>>          /* Only read after generation field verification */
>>          smp_rmb();
>>          /* Re-read to be sure we got the latest version */
>>          vmxnet3_ring_read_curr_cell(d, ring, txd);
>> +        txd->addr =3D le64_to_cpu(txd->addr);
>> +        txd->val1 =3D le32_to_cpu(txd->val1);
>> +        txd->val2 =3D le32_to_cpu(txd->val2);
>=20
> Using inlined func:
>=20
>            vmxnet3_txdesc_pci_to_cpu(txd);

Ok, so that's one of the few spots where a struct is byteswapped not
only in one place, but in two. I guess I could add a inline function for
this...

>>          VMXNET3_RING_DUMP(VMW_RIPRN, "TX", qidx, ring);
>>          *descr_idx =3D vmxnet3_ring_curr_cell_idx(ring);
>>          vmxnet3_inc_tx_consumption_counter(s, qidx);
>> @@ -749,7 +756,7 @@ static void vmxnet3_process_tx_queue(VMXNET3State =
*s, int qidx)
>> =20
>>          if (!s->skip_current_tx_pkt) {
>>              data_len =3D (txd.len > 0) ? txd.len : VMXNET3_MAX_TX_BUF=
_SIZE;
>> -            data_pa =3D le64_to_cpu(txd.addr);
>> +            data_pa =3D txd.addr;
>> =20
>>              if (!net_tx_pkt_add_raw_fragment(s->tx_pkt,
>>                                                  data_pa,
>> @@ -792,6 +799,9 @@ vmxnet3_read_next_rx_descr(VMXNET3State *s, int qi=
dx, int ridx,
>>      Vmxnet3Ring *ring =3D &s->rxq_descr[qidx].rx_ring[ridx];
>>      *didx =3D vmxnet3_ring_curr_cell_idx(ring);
>>      vmxnet3_ring_read_curr_cell(d, ring, dbuf);
>> +    dbuf->addr =3D le64_to_cpu(dbuf->addr);
>> +    dbuf->val1 =3D le32_to_cpu(dbuf->val1);
>> +    dbuf->ext1 =3D le32_to_cpu(dbuf->ext1);
>=20
> again:
>=20
>        vmxnet3_txdesc_pci_to_cpu(dbuf);

That function reads an RX descriptor, not a TX descriptor! And this
descriptor type is only byte-swapped in this single place. And the whole
function body is only 6 lines. So an additional inline function is
really not justified here!

>>  }
>> =20
>>  static inline uint8_t
>> @@ -811,6 +821,9 @@ vmxnet3_pop_rxc_descr(VMXNET3State *s, int qidx, u=
int32_t *descr_gen)
>> =20
>>      pci_dma_read(PCI_DEVICE(s),
>>                   daddr, &rxcd, sizeof(struct Vmxnet3_RxCompDesc));
>> +    rxcd.val1 =3D le32_to_cpu(rxcd.val1);
>> +    rxcd.val2 =3D le32_to_cpu(rxcd.val2);
>> +    rxcd.val3 =3D le32_to_cpu(rxcd.val3);
>=20
>        vmxnet3_txcompdesc_pci_to_cpu(&rxcd);
>=20
>>      ring_gen =3D vmxnet3_ring_curr_gen(&s->rxq_descr[qidx].comp_ring)=
;
>> =20
>>      if (rxcd.gen !=3D ring_gen) {
>> @@ -1098,14 +1111,16 @@ vmxnet3_indicate_packet(VMXNET3State *s)
>>          }
>> =20
>>          chunk_size =3D MIN(bytes_left, rxd.len);
>> -        vmxnet3_pci_dma_writev(d, data, bytes_copied,
>> -                               le64_to_cpu(rxd.addr), chunk_size);
>> +        vmxnet3_pci_dma_writev(d, data, bytes_copied, rxd.addr, chunk=
_size);
>>          bytes_copied +=3D chunk_size;
>>          bytes_left -=3D chunk_size;
>> =20
>>          vmxnet3_dump_rx_descr(&rxd);
>=20
> ^ this dump is incorrect (not host swapped yet).

I think you're wrong, the endianess should be fine here. rxd is ready
via vmxnet3_get_next_rx_descr() which eventually calls
vmxnet3_read_next_rx_descr() and that function is taking care of the
byte-swapping.

>            vmxnet3_rxcompdesc_pci_to_cpu(&rxcd);
>=20
>> =20
>>          if (ready_rxcd_pa !=3D 0) {
>> +            rxcd.val1 =3D le32_to_cpu(rxcd.val1);
>> +            rxcd.val2 =3D le32_to_cpu(rxcd.val2);
>> +            rxcd.val3 =3D le32_to_cpu(rxcd.val3);
>=20
> (out of if)

Why?

>>              pci_dma_write(d, ready_rxcd_pa, &rxcd, sizeof(rxcd));
>>          }
>> =20
>> @@ -1138,6 +1153,9 @@ vmxnet3_indicate_packet(VMXNET3State *s)
>>          rxcd.eop =3D 1;
>>          rxcd.err =3D (bytes_left !=3D 0);
>> =20
>> +        rxcd.val1 =3D le32_to_cpu(rxcd.val1);
>> +        rxcd.val2 =3D le32_to_cpu(rxcd.val2);
>> +        rxcd.val3 =3D le32_to_cpu(rxcd.val3);
>=20
>            vmxnet3_rxcompdesc_pci_to_cpu(&rxcd);
>=20
>>          pci_dma_write(d, ready_rxcd_pa, &rxcd, sizeof(rxcd));

One of the few spots where a struct is written twice. I guess I could
indeed add an inline wrapper for this ... not sure whether it's worth
the effort...

 Thomas
