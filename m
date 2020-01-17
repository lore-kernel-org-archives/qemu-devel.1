Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A71C33CB6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42CFF2072E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuJ/9C51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CFF2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isS7G-0003F9-CZ
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isS4h-0008TK-78
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isS4e-0000NT-Pt
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:54:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39392
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isS4e-0000N0-Jb
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579269247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omMXBaG/R3j6SwCE3i9uictJ6jYSnGPYMl8jnAGjeis=;
 b=iuJ/9C516jesEJhvn5iiNp9J7K6Fo1sAMaMng0P1J23FVyuG9EmICVnG80avsVMMLCjuAe
 DYd4srxK0NqLe8WoZ3s5cyOQeoIoVimIH1bBmYSioqfvMRjuTilLoJWIOhILHqIPPf1Usq
 SeJnS6nrEcFG3Lu2GrXoxaZpKwE1/MA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-bXCNJOWHN5OxYcJYFIJxIg-1; Fri, 17 Jan 2020 08:54:04 -0500
Received: by mail-wr1-f71.google.com with SMTP id y7so10589269wrm.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q7EAGhzf+w7ihkbYMlBIx6rnGz5kICUq0lHscyy23NQ=;
 b=i8yL6OKQ1qqRQfjcAnvK4CQKR/sWeW3AfOAxvApgWJ2ePS1zvKq6LzDWq9alx2ZvUH
 4tsMfvjRIOHCK4TYtZnEHy3qI8C4C4tB6ELOE+e9E1p3rZ9G9kfY/XyF13XxPoKg9O+I
 0MvhQJN8y9h9ctomIHZgvLlwLjbZMoeOyIHX6vAcvK/Yhiu9Ucy7XLaWvLrPXqROGj8u
 U/7uURVuqHAC4P5vaHhAhL3Zc6rGFQMV4nu1w9K8qf6/QEaIcYCcr0S9Haq8dlug1MR8
 33u2eC2XJiGlXZS8rByaCDcd2QcB+7Y4oZ34KHaPBJNlqK2BJxtWEikHehNWL7eHLrPc
 Atvg==
X-Gm-Message-State: APjAAAWvy/Qr4CAGoslBSRrNKAJIPcJzDS67AZrzYHeV6yO0zjaZCI3C
 4pOHc0YW07z66E1mcjnnuWjbHXWqVYMz1HOiVhaY6fifNHce4KorNZjFo9+eThi2fYU+UO2lhwX
 DsPkj1JEWGnZT1eU=
X-Received: by 2002:adf:cd92:: with SMTP id q18mr3095893wrj.261.1579269243235; 
 Fri, 17 Jan 2020 05:54:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZsJ6CJ36lnTXxUlDEmU+RqHNndBhQSQsj73LDlCDAw0yGTHqajPPBgiBMhOqVWzLnDrQzkA==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr3095862wrj.261.1579269242914; 
 Fri, 17 Jan 2020 05:54:02 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id x11sm12474wmg.46.2020.01.17.05.54.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 05:54:02 -0800 (PST)
Subject: Re: [PATCH 090/104] virtiofsd: rename inode->refcount to
 inode->nlookup
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-91-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e7785611-bc4b-8c52-08d2-4208cf3dfe38@redhat.com>
Date: Fri, 17 Jan 2020 14:54:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-91-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: bXCNJOWHN5OxYcJYFIJxIg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 5:38 PM, Dr. David Alan Gilbert (git) wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> This reference counter plays a specific role in the FUSE protocol.  It's
> not a generic object reference counter and the FUSE kernel code calls it
> "nlookup".
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tools/virtiofsd/passthrough_ll.c | 37 +++++++++++++++++++++-----------
>   1 file changed, 25 insertions(+), 12 deletions(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 7663e574d8..b19c9ee328 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -101,7 +101,20 @@ struct lo_inode {
>       int fd;
>       bool is_symlink;
>       struct lo_key key;
> -    uint64_t refcount; /* protected by lo->mutex */
> +
> +    /*
> +     * This counter keeps the inode alive during the FUSE session.
> +     * Incremented when the FUSE inode number is sent in a reply
> +     * (FUSE_LOOKUP, FUSE_READDIRPLUS, etc).  Decremented when an inode =
is
> +     * released by requests like FUSE_FORGET, FUSE_RMDIR, FUSE_RENAME, e=
tc.
> +     *
> +     * Note that this value is untrusted because the client can manipula=
te
> +     * it arbitrarily using FUSE_FORGET requests.
> +     *
> +     * Protected by lo->mutex.
> +     */
> +    uint64_t nlookup;
> +
>       fuse_ino_t fuse_ino;
>       pthread_mutex_t plock_mutex;
>       GHashTable *posix_locks; /* protected by lo_inode->plock_mutex */
> @@ -570,7 +583,7 @@ retry:
>       if (last =3D=3D path) {
>           p =3D &lo->root;
>           pthread_mutex_lock(&lo->mutex);
> -        p->refcount++;
> +        p->nlookup++;
>           pthread_mutex_unlock(&lo->mutex);
>       } else {
>           *last =3D '\0';
> @@ -788,8 +801,8 @@ static struct lo_inode *lo_find(struct lo_data *lo, s=
truct stat *st)
>       pthread_mutex_lock(&lo->mutex);
>       p =3D g_hash_table_lookup(lo->inodes, &key);
>       if (p) {
> -        assert(p->refcount > 0);
> -        p->refcount++;
> +        assert(p->nlookup > 0);
> +        p->nlookup++;
>       }
>       pthread_mutex_unlock(&lo->mutex);
>  =20
> @@ -857,7 +870,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pa=
rent, const char *name,
>           }
>  =20
>           inode->is_symlink =3D S_ISLNK(e->attr.st_mode);
> -        inode->refcount =3D 1;
> +        inode->nlookup =3D 1;
>           inode->fd =3D newfd;
>           newfd =3D -1;
>           inode->key.ino =3D e->attr.st_ino;
> @@ -1097,7 +1110,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino,=
 fuse_ino_t parent,
>       }
>  =20
>       pthread_mutex_lock(&lo->mutex);
> -    inode->refcount++;
> +    inode->nlookup++;
>       pthread_mutex_unlock(&lo->mutex);
>       e.ino =3D inode->fuse_ino;
>  =20
> @@ -1226,9 +1239,9 @@ static void unref_inode_lolocked(struct lo_data *lo=
, struct lo_inode *inode,
>       }
>  =20
>       pthread_mutex_lock(&lo->mutex);
> -    assert(inode->refcount >=3D n);
> -    inode->refcount -=3D n;
> -    if (!inode->refcount) {
> +    assert(inode->nlookup >=3D n);
> +    inode->nlookup -=3D n;
> +    if (!inode->nlookup) {
>           lo_map_remove(&lo->ino_map, inode->fuse_ino);
>           g_hash_table_remove(lo->inodes, &inode->key);
>           if (g_hash_table_size(inode->posix_locks)) {
> @@ -1249,7 +1262,7 @@ static int unref_all_inodes_cb(gpointer key, gpoint=
er value, gpointer user_data)
>       struct lo_inode *inode =3D value;
>       struct lo_data *lo =3D user_data;
>  =20
> -    inode->refcount =3D 0;
> +    inode->nlookup =3D 0;
>       lo_map_remove(&lo->ino_map, inode->fuse_ino);
>       close(inode->fd);
>  =20
> @@ -1274,7 +1287,7 @@ static void lo_forget_one(fuse_req_t req, fuse_ino_=
t ino, uint64_t nlookup)
>       }
>  =20
>       fuse_log(FUSE_LOG_DEBUG, "  forget %lli %lli -%lli\n",
> -             (unsigned long long)ino, (unsigned long long)inode->refcoun=
t,
> +             (unsigned long long)ino, (unsigned long long)inode->nlookup=
,
>                (unsigned long long)nlookup);
>  =20
>       unref_inode_lolocked(lo, inode, nlookup);
> @@ -2642,7 +2655,7 @@ static void setup_root(struct lo_data *lo, struct l=
o_inode *root)
>       root->fd =3D fd;
>       root->key.ino =3D stat.st_ino;
>       root->key.dev =3D stat.st_dev;
> -    root->refcount =3D 2;
> +    root->nlookup =3D 2;
>   }
>  =20
>   static guint lo_key_hash(gconstpointer key)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


