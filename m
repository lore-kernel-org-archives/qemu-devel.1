Received: from eggs.gnu.org ([2001:4830:134:3::10]:59180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f1bpY-0003j7-1X
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 13:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f1bpX-00038W-E2
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 13:59:20 -0400
Received: from mail-yb0-x236.google.com ([2607:f8b0:4002:c09::236]:41156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f1bpX-00037u-9P
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 13:59:19 -0400
Received: by mail-yb0-x236.google.com with SMTP id x72-v6so2265137ybe.8
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 10:59:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMo8BfKW3g6K4MU+eEz71Cq-FaSWox4ffHjj-1_zj9jM9CB7jw@mail.gmail.com>
References: <CAMo8BfKW3g6K4MU+eEz71Cq-FaSWox4ffHjj-1_zj9jM9CB7jw@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 29 Mar 2018 10:59:17 -0700
Message-ID: <CAMo8Bf+5Rg=OKY8jh4330brGUi=nb4S=Bzq2LwOXtAX5SGa-4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] linux-user: missing synchronization in CPU object
 realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On Thu, Mar 29, 2018 at 7:15 AM, Max Filippov <jcmvbkbc@gmail.com> wrote:
> I'm running xtensa linux-user application that rapidly creates
> a lot of threads and I observe the following assertion failure:
>
> (process:26953): GLib-CRITICAL **: g_hash_table_iter_next: assertion
> 'ri->version == ri->hash_table->version' failed
> **
> ERROR:qemu/qom/object.c:1663:object_get_canonical_path_component: code
> should not be reached

[...]

> This happens because multiple threads concurrently call
> object_property_set_bool to realize cpu object in cpu_create,
> which results in the following call chain:
>   device_set_realized -> object_property_add_child ->
>   object_property_add -> g_hash_table_insert
> inserting newly created CPUs as children to /unattached without
> any locking.

Looking at it some more I wonder why do we build this object tree
n linux-user in the first place? It doesn't seem to be used anywhere.

-- 
Thanks.
-- Max
