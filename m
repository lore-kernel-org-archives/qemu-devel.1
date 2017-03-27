Received: from eggs.gnu.org ([2001:4830:134:3::10]:51804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1csSaL-0000sF-GG
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1csSaG-0000ZW-JQ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:13:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1csSaG-0000ZA-Do
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:13:12 -0400
Date: Mon, 27 Mar 2017 12:13:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170327111309.GB26900@stefanha-x1.localdomain>
References: <1490610662-5483-1-git-send-email-tejaswinipoluri3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <1490610662-5483-1-git-send-email-tejaswinipoluri3@gmail.com>
Subject: Re: [Qemu-devel] [[RFC]PATCH:hw/sd:sd_init()] hw/sd : modified the
 sd_init() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tejaswini <tejaswinipoluri3@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 27, 2017 at 04:01:02PM +0530, Tejaswini wrote:
> From: Tejaswini Poluri <tejaswinipoluri3@gmail.com>

Please shorten the subject line: "[PATCH] hw/sd: simplify sd_init() prototype"

> @@ -573,16 +573,19 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
>      qdev_prop_set_drive(dev, "drive", blk, &err);
>      if (err) {
>          error_report("sd_init failed: %s", error_get_pretty(err));
> -        return NULL;
> +        return -1;
>      }
>      qdev_prop_set_bit(dev, "spi", is_spi);
>      object_property_set_bool(obj, true, "realized", &err);
>      if (err) {
>          error_report("sd_init failed: %s", error_get_pretty(err));
> -        return NULL;
> +        return -1;
>      }
> -
> -    return SD_CARD(dev);
> +    sd_state = SD_CARD(dev);

The caller will not see the new value of sd_state.  In C arguments are
passed by value.  That means they are local variables inside the
function and do not affect the caller.

I have CCed Paolo Bonzini, who posted this task.  Maybe he can explain
what he meant by "Include SDState by value instead of allocating it in
sd_init (hw/sd/)".

> +    if (!sd_state) {
> +		return -1;
> +	}

QEMU use 4 space indentation.  Please do not use tabs.

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBAgAGBQJY2PPFAAoJEJykq7OBq3PIYx0H+P+1vce7Z0isy1XShBEh4eOk
2ewEfKFGMQiK8F++hXGXBR/p4FZHV5X3RQRU2/inkazVy5vLMgwBmSEiHIbnTo3G
lNNOhRx7vjFTAvotl+3HevZ6J6XhVdhbPgOD7aYZt1lKieX8CK1eGlFGJ8R6sqUt
SNWNena6uQ2L0Ppoag0VQu1O+evm20FVg6uITJEFPtVpRDbfY8gK4hWRMQAYsvHa
VGj6s7iGz0OYUZPnCqx68bfY16Tn+/eNjcyC/eapG79Z2/xQtrxTg2Zol+KqaSnZ
sTJVUQdAQa1iZAV+fMJBIm6+oi6AwBnJBnHnLvX6Z4pZpAJ97PUZLmRnkJMF4Q==
=8baK
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
