Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE7AC3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F3320673
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNY2tMAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F3320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCKcV-0002lJ-3L
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iCKbT-00023Y-8S
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iCKbR-0001TN-Rq
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:25:55 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43807)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iCKbR-0001S8-HA
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:25:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id q17so13059855wrx.10
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 02:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Di+FjqbLdJNjZf++OEu4rj9a0E/g9qvQ7pQiL7oy6PQ=;
 b=DNY2tMAHL8eVuk+ZqjGbMeF3rvLb0ZNOKz/syTaEGcPQwIBfaqyX6AdbIxeLNSP+Nf
 I5aMcOquXpl4dff6OgU0SvfPL3G8AmR6hEoZOZpNZBT3QhbqkSEJ2xRpwLKRMFbpzmL4
 r0ppbMOcItnrCGY6rdbpdyqekFXiRbw42qa4bA+Pid7jH1WSnXixGZUHrHkBIKb8VpQG
 TqeBNxbamDryx15bxSc81Jdj8n9XvRTbHKNV+GMqJN8I052oattigst/TJ8+uPX2462H
 Z90f0M6VQRIUg5ntxAve016Lp/WhIi4gP6RkzVVj/jDUnbjxNq1okv+0hNCRFaDb13qb
 SHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Di+FjqbLdJNjZf++OEu4rj9a0E/g9qvQ7pQiL7oy6PQ=;
 b=ko+mXEwq1onyKGmvmMi8d5qMI9lF/u/ZQbb0VIKqVD+PxiqAiTg1DwIFgUo3bIKjfB
 1ONoKR+ngYs7R5grRue5Y233FgHYvsalHhOfVW/OvBvAoh0Oe3oPyX7eUWLEg3NH0KP+
 ouA6m2fV9N8pNI6iIkcS6+/tb+0fDFh+aenM9LiGIf1POGN5rIHHVXv1ek6kfJwbHa0s
 C1r/GYYqe0VmxyjZjuMN45TQ8VKZp9XqoWjRCqG5P8bGwKBsEsPa1R571TgI9xqS6Ybr
 NPx89kGv3/lPP13fe0Q1AyJOoA++Tak1znb1lzeWfzDO+JJXBocdXplqBzoak0UM7xmV
 U4aw==
X-Gm-Message-State: APjAAAX/0d1IzJ8HoJBwEvrhsivvDUrsKxX4uQq11C8/q6USns4aSP1P
 8VjMhJ4TzpcZkjYHv9l3Z9c=
X-Google-Smtp-Source: APXvYqyWvIHn4VvgTL3yYvB4RdAOwPCARbMuwR1BSrORGVDYoPB1ClclRuK/+QUaHo6qIdz70D1eYg==
X-Received: by 2002:adf:e5c2:: with SMTP id a2mr20228909wrn.320.1569230751763; 
 Mon, 23 Sep 2019 02:25:51 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id t1sm9590476wrn.57.2019.09.23.02.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 02:25:50 -0700 (PDT)
Date: Mon, 23 Sep 2019 10:25:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [Qemu-devel] [RFC] contrib: add vhost-user-sim
Message-ID: <20190923092548.GA26219@stefanha-x1.localdomain>
References: <20190917122644.15736-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20190917122644.15736-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Johannes Berg <johannes.berg@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2019 at 02:26:44PM +0200, Johannes Berg wrote:
> +static int unix_sock_new(const char *unix_fn)
> +{
> +    int sock;
> +    struct sockaddr_un un;
> +    size_t len;
> +
> +    g_assert(unix_fn);
> +
> +    sock = socket(AF_UNIX, SOCK_STREAM, 0);
> +    if (sock <= 0) {
> +        perror("socket");
> +        g_assert(0);
> +        return -1;
> +    }
> +
> +    un.sun_family = AF_UNIX;
> +    (void)snprintf(un.sun_path, sizeof(un.sun_path), "%s", unix_fn);
> +    len = sizeof(un.sun_family) + strlen(un.sun_path);

According to unix(7):

  The addrlen argument that describes the enclosing sockaddr_un
  structure should have a value of at least:

    offsetof(struct sockaddr_un, sun_path)+strlen(addr.sun_path)+1

  or, more simply, addrlen can be specified as sizeof(struct sockaddr_un).

Please either increase len by 1 or use sizeof(struct sockaddr_un).

> +gboolean vu_net_client_connected(GIOChannel *src,
> +                                 GIOCondition cond,
> +                                 gpointer data)
> +{
> +    int lsock = g_io_channel_unix_get_fd(src);
> +    int csock = accept(lsock, NULL, NULL);
> +    VuNetDev *ndev;
> +
> +    if (csock < 0) {
> +        fprintf(stderr, "Accept error %s\n", strerror(errno));
> +        return TRUE;
> +    }
> +
> +    ndev = g_new0(VuNetDev, 1);
> +    if (!ndev) {

g_new0() cannot return NULL, please remove this if statement.

> +static int full_read(int fd, void *_buf, size_t len)
> +{
> +    unsigned char *buf = _buf;
> +    ssize_t ret;
> +
> +    do {
> +        ret = read(fd, buf, len);
> +        if (ret > 0) {
> +            buf += ret;
> +            len -= ret;
> +        } else if (ret == 0) {
> +            return 0;
> +        } else {
> +            return -errno;
> +        }

Want to loop on EINTR?

> +    } while (len > 0);
> +
> +    return buf - (unsigned char *)_buf;
> +}
> +
> +static int full_write(int fd, const void *_buf, size_t len)
> +{
> +    const unsigned char *buf = _buf;
> +    ssize_t ret;
> +
> +    do {
> +        ret = write(fd, buf, len);
> +        if (ret > 0) {
> +            buf += ret;
> +            len -= ret;
> +        } else if (ret == 0) {
> +            return 0;
> +        } else {
> +            return -errno;

EINTR?

> +        }
> +    } while (len > 0);
> +
> +    return buf - (const unsigned char *)_buf;
> +}
> +
> +static void simtime_handle_message(SimTimeConnection *conn,
> +                                   struct um_timetravel_msg *msg)
> +{
> +    struct um_timetravel_msg resp = {
> +        .op = UM_TIMETRAVEL_ACK,
> +    };
> +
> +    DPRINT(" %d | message %s (%lld, time=%lld)\n",
> +           conn->idx, simtime_op_str(msg->op), msg->op, msg->time);
> +
> +    switch (msg->op) {
> +    case UM_TIMETRAVEL_REQUEST:
> +        if (calendar_entry_remove(&conn->entry)) {
> +            conn->entry.time = conn->offset + msg->time;
> +            calendar_entry_add(&conn->entry);
> +            DPRINT(" %d | calendar entry added for %lld\n", conn->idx, msg->time);
> +        } else {
> +            conn->entry.time = conn->offset + msg->time;
> +            DPRINT(" %d | calendar entry time updated for %lld\n", conn->idx, msg->time);
> +        }

Just checking the expected semantics:

If the entry was already added, then we update the time and it stays
scheduled.  If the entry was not already added then we just stash away
the time but don't schedule it?

Also, are the DPRINT() messages swapped in the if ... else ... bodies?
They seem to be talking about the other case.

> +    conn = g_new0(SimTimeConnection, 1);
> +    if (!conn) {
> +        return TRUE;
> +    }

g_new0() does not fail.  If it did, then csock would be leaked here.
Please drop the if statement.

> diff --git a/include/standard-headers/linux/um_timetravel.h b/include/standard-headers/linux/um_timetravel.h
> new file mode 100644
> index 000000000000..3aaced426a92
> --- /dev/null
> +++ b/include/standard-headers/linux/um_timetravel.h
> @@ -0,0 +1,107 @@

Please use scripts/update-linux-headers.sh to import this header file
with the necessary conversions (e.g. #include <linux/types.h> ->
#include "standard-headers/linux/types.h", __u64 -> uint64_t).

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2Ij5wACgkQnKSrs4Gr
c8hD5wgAhaB9+hHzH13S8jZod8OvJnsJZq+VobN+ab9LLyppYm/bLWqfyEepRBrv
xuH3LWuqThNlxBxpFLthV+UTQ/2zOCPPNgWXz4YhuXWjHwRm8RwO+Pb/ePls4pLA
sdz1Y0tvHwl0fLx1N1Sf2F8ECtNU6Pr/ZMmphfw3h1Si0Z2k9uIJg5VRKil0Yf3w
mtND3ZtygIkEE5fJWrETFUiveYq1c/3Im+6so5INNKTnHiE+qcA7k1346P11Ua5H
dBbVUNAOBuOTKq8nh3n/1IQuwYNjzYhkdwWdbdrQlc6jEgq2rHzoo9j3/0nwBl5R
YK9pYNZiFFAkErinLU9ihKyYM4/YNw==
=wOOM
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

