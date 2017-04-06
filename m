Received: from eggs.gnu.org ([2001:4830:134:3::10]:58776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw4c3-0004HJ-0T
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw4by-0004yA-3C
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:25:59 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cw4bx-0004xP-Sz
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:25:54 -0400
Received: by mail-wr0-x232.google.com with SMTP id g19so10527916wrb.0
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 03:25:53 -0700 (PDT)
Date: Thu, 6 Apr 2017 11:25:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406102550.GB21895@stefanha-x1.localdomain>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170331084147.32716-5-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <20170331084147.32716-5-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] nvdimm acpi: build flush hint
 address structure if required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, dan.j.williams@intel.com, Richard Henderson <rth@twiddle.net>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 31, 2017 at 04:41:47PM +0800, Haozhong Zhang wrote:
> +/*
> + * ACPI 6.0: 5.2.25.7 Flush Hint Address Structure
> + */
> +static void nvdimm_build_structure_flush_hint(GArray *structures,
> +                                              DeviceState *dev,
> +                                              unsigned int cache_line_size,
> +                                              Error **errp)
> +{
> +    NvdimmNfitFlushHintAddress *flush_hint;
> +    int slot = object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP, NULL);
> +    PCDIMMDevice *dimm = PC_DIMM(dev);
> +    NVDIMMDevice *nvdimm = NVDIMM(dev);
> +    uint64_t addr;
> +    unsigned int i;
> +    MemoryRegion *mr;
> +    Error *local_err = NULL;
> +
> +    if (!nvdimm->flush_hint_enabled) {
> +        return;
> +    }
> +
> +    if (cache_line_size * NR_FLUSH_HINT_ADDR > dimm->reserved_size) {
> +        error_setg(&local_err,
> +                   "insufficient reserved space for flush hint buffers");
> +        goto out;
> +    }
> +
> +    addr = object_property_get_int(OBJECT(dev), PC_DIMM_ADDR_PROP, NULL);
> +    addr += object_property_get_int(OBJECT(dev), PC_DIMM_SIZE_PROP, NULL);
> +
> +    flush_hint = acpi_data_push(structures, sizeof(*flush_hint));
> +    flush_hint->type = cpu_to_le16(6 /* Flush Hint Address Structure */);
> +    flush_hint->length = cpu_to_le16(sizeof(*flush_hint));
> +    flush_hint->nfit_handle = cpu_to_le32(nvdimm_slot_to_handle(slot));
> +    flush_hint->nr_flush_hint_addr = cpu_to_le16(NR_FLUSH_HINT_ADDR);
> +
> +    for (i = 0; i < NR_FLUSH_HINT_ADDR; i++, addr += cache_line_size) {
> +        flush_hint->flush_hint_addr[i] = cpu_to_le64(addr);
> +
> +        mr = g_new0(MemoryRegion, 1);
> +        memory_region_init_io(mr, OBJECT(dev), &nvdimm_flush_hint_ops, nvdimm,
> +                              "nvdimm-flush-hint", cache_line_size);
> +        memory_region_add_subregion(get_system_memory(), addr, mr);

It would be cleaner to create the memory region in the nvdimm device
code instead of the acpi code.

The acpi code just needs to get the number of flush hints and the MMIO
page address from the nvdimm device.  It doesn't need to create the
memory region object or provide the read/write functions.

Stefan

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5heuAAoJEJykq7OBq3PIUzwH/R7OQ+x6pf0mh7UMGg2HpK5Q
EUxbc+r9kSddfOI7cUxw2et3MN7imVftJhG8LeiRhcgajyMaawTC3RNVXMFYgZfo
pDzVpZVVIhfwpMlLO1yayakhcT1c9eyfuVbxjyq0P1HxE2PZEIZgO5EbyDTZwKH/
sWhTCL1Tm34I11i0jwROPFBrSOFOQEyNumBoGjk5uf3pJUBFtYfMEyiDCu9pTMav
yz+pAMz4F54Mc3+LYZFJFKVYI6FnQG/HU6+OBIC4aPbiR6GVB+2cFELyM3vvKv0E
uIzfv7ABBXs6/QlT/NeuRdbexX/7vrYpFCgobK8cQUJZWO/bJoypZ4JPIAL7tw4=
=ji8q
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
