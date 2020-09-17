Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E3C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF202072E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECCof+kP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF202072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kItnv-0007ns-Fn
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 09:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kItnD-0007K8-P7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kItnA-0002Z1-PX
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600348657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BIH/ThdAQe02LTxf0Z0AJ/4mC2KF16kTp6dKHGZTRGE=;
 b=ECCof+kPh3FQ4hIM8+gJSxIK9ZAyXGFhMxwEk4rilOYOanLFYZQ2HdDVSU6lsHbQNn6o99
 ri7bWwFC5JfUy05Pucdc6E8ejEMuSveJCNIqNOX47Pf3PZj+Mj8j5zsWyPx9sxHok3KBri
 KQLkqkcYaKaMABZEiFK1/YWLq591aYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-r1_OTJZpOAaBSO_WPFP6Rg-1; Thu, 17 Sep 2020 09:17:36 -0400
X-MC-Unique: r1_OTJZpOAaBSO_WPFP6Rg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FFEB106B82C;
 Thu, 17 Sep 2020 13:17:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-65.ams2.redhat.com
 [10.36.113.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCD255DE51;
 Thu, 17 Sep 2020 13:16:58 +0000 (UTC)
Subject: Re: [PATCH 1/2] file-posix: Correctly read max_segments of SG nodes
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>, Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200811225122.17342-1-dmitry.fomichev@wdc.com>
 <20200811225122.17342-2-dmitry.fomichev@wdc.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <808e395e-6f99-acdb-03dc-400f6bd32311@redhat.com>
Date: Thu, 17 Sep 2020 15:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811225122.17342-2-dmitry.fomichev@wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Damien Le Moal <damien.lemoal@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12.08.20 00:51, Dmitry Fomichev wrote:
> If scsi-generic driver is in use, an SG node can be specified in
> the command line in place of a regular SCSI device. In this case,
> sg_get_max_segments() fails to open max_segments entry in sysfs
> because /dev/sgX is a character device. As the result, the maximum
> transfer size for the device may be calculated incorrectly, causing
> I/O errors if the maximum transfer size at the guest ends up to be
> larger compared to the host.
> 
> Check system device type in sg_get_max_segments() and read the
> max_segments value differently if it is a character device.
> 
> Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Fixes: 9103f1ceb46614b150bcbc3c9a4fbc72b47fedcc
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  block/file-posix.c | 55 +++++++++++++++++++++++++++-------------------
>  1 file changed, 32 insertions(+), 23 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 094e3b0212..f9e2424e8f 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1108,6 +1108,7 @@ static int sg_get_max_segments(int fd)
>      int ret;
>      int sysfd = -1;
>      long max_segments;
> +    unsigned int max_segs;
>      struct stat st;
>  
>      if (fstat(fd, &st)) {
> @@ -1115,30 +1116,38 @@ static int sg_get_max_segments(int fd)
>          goto out;
>      }
>  
> -    sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/max_segments",
> -                                major(st.st_rdev), minor(st.st_rdev));
> -    sysfd = open(sysfspath, O_RDONLY);
> -    if (sysfd == -1) {
> -        ret = -errno;
> -        goto out;
> +    if (S_ISBLK(st.st_mode)) {
> +        sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/max_segments",
> +                                    major(st.st_rdev), minor(st.st_rdev));

Sounds reasonable, but this function is (naturally) only called if
bs->sg is true, which is set by hdev_is_sg(), which returns true only if
the device file is a character device.

So is this path ever taken, or can we just replace it all with the ioctl?

(Before 867eccfed84, this function was used for all host devices, which
might explain why the code even exists.)

Max


