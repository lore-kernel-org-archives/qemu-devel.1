Received: from eggs.gnu.org ([2001:4830:134:3::10]:57044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eTMhU-0004zx-EY
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 01:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eTMhQ-0001IQ-GQ
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 01:57:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eTMhQ-0001Hc-A8
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 01:57:24 -0500
Date: Mon, 25 Dec 2017 14:57:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171225065717.GK2443@xz-mi>
References: <1513836919-13458-1-git-send-email-yi.l.liu@linux.intel.com>
	<20171225054522.GI2443@xz-mi> <20171225061933.GA21722@sky-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171225061933.GA21722@sky-dev>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: a fix to
 vtd_dev_get_trans_type()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: jasowang@redhat.com, yi.l.liu@intel.com, qemu-devel@nongnu.org

On Mon, Dec 25, 2017 at 02:19:33PM +0800, Liu, Yi L wrote:
> On Mon, Dec 25, 2017 at 01:45:22PM +0800, Peter Xu wrote:
> > On Thu, Dec 21, 2017 at 02:15:19PM +0800, Liu, Yi L wrote:
> > > vtd_ce_get_type() returns uin32_t and vtd_dev_get_trans_type() returns
> > > the value from vtd_ce_get_type(). However, vtd_dev_get_trans_type()
> > > returns int. This patch switchs to return the translation type by
> > > parameter. It avoids unsigned to int transfer and also avoid potential
> > > reading confusion.
> > 
> > Frankly speaking I would still prefer the old way to do it: return
> > type when >=0 and error when <0.  After all we have a comment for
> > vtd_dev_get_trans_type() already:
> > 
> > /*
> >  * Fetch translation type for specific device. Returns <0 if error
> >  * happens, otherwise return the shifted type to check against
> >  * VTD_CONTEXT_TT_*.
> >  */
> 
> Peter,
> 
> I knew your point. It's not a bug. However, it depends on
> vtd_ce_get_type(), if it returns a value with the most significant
> bit=1, then it may be wrongly treated as a negative value. It is not
> possible so far, but it may be an issue if future spec place the
> translation type in bit 31:29, and type 3'b100 is valid. It's an
> assumption. Then the return value of vtd_ce_get_type() is 0x80000000,
> and it would be treated as -2147483648. This should be a mistake.
> That's why I want to separate the return value and the translation type.

Is it forseeable that we'll use any of the bits there?  AFAIK now 11b
is still reserved for translation type so at least we still have one
extra new type.  Even if so, I would prefer to do it when QEMU VT-d
supports that new type.  Or, convert current "shifted bitmask" into an
enum.  That would be even cleaner to me.  Thanks,

-- 
Peter Xu
