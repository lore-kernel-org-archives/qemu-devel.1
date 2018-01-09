Received: from eggs.gnu.org ([2001:4830:134:3::10]:39462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eYxtz-0004NO-Ci
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eYxtw-0003uj-BQ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:41:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eYxtw-0003td-3e
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:41:28 -0500
Date: Tue, 9 Jan 2018 19:41:13 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180109193800-mutt-send-email-mst@kernel.org>
References: <1514626559-162312-1-git-send-email-longpeng2@huawei.com>
	<1514626559-162312-2-git-send-email-longpeng2@huawei.com>
	<fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [v23 1/2] virtio-crypto: Add virtio crypto device
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Longpeng(Mike)" <longpeng2@huawei.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com

On Tue, Jan 09, 2018 at 06:05:41PM +0100, Halil Pasic wrote:
> > +\drivernormative{\subsubsection}{Device configuration layout}{Device Types / Crypto Device / Device configuration layout}
> > +
> > +\begin{itemize*}
> > +\item The driver MUST read the \field{status} from the bottom bit of status to check whether the
> > +    VIRTIO_CRYPTO_S_HW_READY is set, and the driver MUST reread it after device reset.
> > +\item The driver MUST NOT transmit any requests to the device if the VIRTIO_CRYPTO_S_HW_READY is not set.
> > +\item The driver MUST read \field{max_dataqueues} field to discover the number of data queues the device supports.
> > +\item The driver MUST read \field{crypto_services} field to discover which services the device is able to offer.
> > +\item The driver SHOULD ignore the not defined algorithms bits.
> > +\item The driver MUST read the detailed algorithms fields based on \field{crypto_services} field.
> > +\item The driver SHOULD read \field{max_size} to discover the maximum size of crypto request the device supports.
> > +\item The driver SHOULD read \field{max_cipher_key_len} to discover the maximum length of cipher key
> > +    the device supports.
> > +\item The driver SHOULD read \field{max_auth_key_len} to discover the maximum length of authenticated
> > +    key the device supports.
> > +\end{itemize*}
> 
> Seems to like a common practice in the virtio spec to say SHOULD read some
> config space parameter in a driver normative but then having no driver normative
> about the operational implications of the parameter.
> 
> While I do think that the reader is usually fully capable of inferring
> the operational requirement, I find it a bit strange: having the operational
> stuff explicit (and possibly needs to be read from the config space implicit)
> seems more straight forward to me.
> 
> Anyway, you are consistent with the rest of the spec, so prefer keeping it
> like this.

The reason for this in virtio generally is that driver is really
only required to be consistent with the device.
Something like reading the value once and storing in e.g.
registry, then using the stored value from registry on
following values seems to also be ok.

Restricting values below the limits allowed by the device
also seems to be ok.
