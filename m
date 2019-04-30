Received: from eggs.gnu.org ([209.51.188.92]:39173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLW23-000491-0t
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLW21-0001xK-RV
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:02 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLW21-0001wj-Kw
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:01 -0400
Received: by mail-ot1-x344.google.com with SMTP id g24so7967384otq.2
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190425132134.2839-1-cohuck@redhat.com>
	<20190425132134.2839-2-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-2-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 17:54:49 +0100
Message-ID: <CAFEAcA8TvMqZRCrMF5orgaWy-CxTR8fr6yF2W_-Y6LYfi1pGng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 01/19] s390 vfio-ccw: Add bootindex property
 and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Jason J. Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>

On Thu, 25 Apr 2019 at 14:21, Cornelia Huck <cohuck@redhat.com> wrote:
>
> From: "Jason J. Herne" <jjherne@linux.ibm.com>
>
> Add bootindex property and iplb data for vfio-ccw devices. This allows us to
> forward boot information into the bios for vfio-ccw devices.
>
> Refactor s390_get_ccw_device() to return device type. This prevents us from
> having to use messy casting logic in several places.
>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <1554388475-18329-2-git-send-email-jjherne@linux.ibm.com>
> [thuth: fixed "typedef struct VFIOCCWDevice" build failure with clang]
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Hi; Coverity has a complaint (CID 1401098) about the use of
object_dynamic_cast() in this function. It looks like it's just
the result of code motion making it forget we'd dismissed the
warning before, but maybe we can avoid it entirely...

> @@ -335,20 +360,22 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>  {
>      DeviceState *dev_st;
>      CcwDevice *ccw_dev = NULL;
> +    SCSIDevice *sd;
> +    int devtype;
>
>      dev_st = get_boot_device(0);
>      if (dev_st) {
> -        ccw_dev = s390_get_ccw_device(dev_st);
> +        ccw_dev = s390_get_ccw_device(dev_st, &devtype);
>      }
>
>      /*
>       * Currently allow IPL only from CCW devices.
>       */
>      if (ccw_dev) {
> -        SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
> -                                                            TYPE_SCSI_DEVICE);
> -
> -        if (sd) {
> +        switch (devtype) {
> +        case CCW_DEVTYPE_SCSI:
> +            sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
> +                                                           TYPE_SCSI_DEVICE);

Coverity doesn't like the use of object_dynamic_cast() without a
check that the return value isn't NULL before we dereference
it a few lines further down.

I think that if we know this cast must always succeed, we
could instead just write
  SCSIDevice *sd = SCSI_DEVICE(dev_st);

On the other hand if the cast might not succeed because dev_st
isn't necessarily of the right type, then we should check it
for NULL and handle that appropriately.

thanks
-- PMM
