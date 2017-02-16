Received: from eggs.gnu.org ([2001:4830:134:3::10]:47762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1ceCG7-0006SL-2k
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1ceCG6-0000nM-4U
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:57:27 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:34891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1ceCG5-0000nE-WD
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:57:26 -0500
Received: by mail-it0-x241.google.com with SMTP id 203so1679685ith.2
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 18:57:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170213145732.GN10361@stefanha-x1.localdomain>
References: <1486527494-3387-1-git-send-email-Ashish.Mittal@veritas.com>
	<20170213145732.GN10361@stefanha-x1.localdomain>
From: ashish mittal <ashmit602@gmail.com>
Date: Wed, 15 Feb 2017 18:57:24 -0800
Message-ID: <CAAo6VWNzuzMNEUjy4J+XKyuZhetf38-DOZTXOJsrnNVRX3fcNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v7 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Mon, Feb 13, 2017 at 6:57 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Feb 07, 2017 at 08:18:13PM -0800, Ashish Mittal wrote:
>> +static int vxhs_parse_uri(const char *filename, QDict *options)
>> +{
>> +    URI *uri = NULL;
>> +    char *hoststr, *portstr;
>> +    char *port;
>> +    int ret = 0;
>> +
>> +    trace_vxhs_parse_uri_filename(filename);
>> +    uri = uri_parse(filename);
>> +    if (!uri || !uri->server || !uri->path) {
>> +        uri_free(uri);
>> +        return -EINVAL;
>> +    }
>> +
>> +    hoststr = g_strdup(VXHS_OPT_SERVER".host");
>> +    qdict_put(options, hoststr, qstring_from_str(uri->server));
>> +    g_free(hoststr);
>> +
>> +    portstr = g_strdup(VXHS_OPT_SERVER".port");
>> +    if (uri->port) {
>> +        port = g_strdup_printf("%d", uri->port);
>> +        qdict_put(options, portstr, qstring_from_str(port));
>> +        g_free(port);
>> +    }
>> +    g_free(portstr);
>> +
>> +    if (strstr(uri->path, "vxhs") == NULL) {
>> +        qdict_put(options, "vdisk-id", qstring_from_str(uri->path));
>> +    }
>> +
>> +    trace_vxhs_parse_uri_hostinfo(1, uri->server, uri->port);
>
> What is the purpose of the first argument?
>

It used to be a placeholder for the host index, which is now only 1. I
will remove it.

>> +    str = g_strdup_printf(VXHS_OPT_SERVER".");
>> +    qdict_extract_subqdict(options, &backing_options, str);
>> +
>> +    /* Create opts info from runtime_tcp_opts list */
>> +    tcp_opts = qemu_opts_create(&runtime_tcp_opts, NULL, 0, &error_abort);
>> +    qemu_opts_absorb_qdict(tcp_opts, backing_options, &local_err);
>> +    if (local_err) {
>> +        qdict_del(backing_options, str);
>
> What is qdict_del(backing_options, VXHS_OPT_SERVER".") supposed to do?
> The same call is made further down too.
>

Per my understanding, qdict_del() is to free the 'server.' entries
within the subqdict.

qdict_extract_subqdict() allocates a subqdict and populates it with
the entries based on the pattern we pass. In this case 'server.'.

>> +        qemu_opts_del(tcp_opts);
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>> +
>> +    server_host_opt = qemu_opt_get(tcp_opts, VXHS_OPT_HOST);
>> +    if (!server_host_opt) {
>> +        error_setg(&local_err, QERR_MISSING_PARAMETER,
>> +                   VXHS_OPT_SERVER"."VXHS_OPT_HOST);
>> +        ret = -EINVAL;
>> +        goto out;
>
> Missing qemu_opts_del(tcp_opts).
>

Will fix this!

>> +    }
>> +
>> +    if (strlen(server_host_opt) > MAXHOSTNAMELEN) {
>> +        error_setg(errp, "server.host cannot be more than %d characters",
>> +                   MAXHOSTNAMELEN);
>> +        ret = -EINVAL;
>> +        goto out;
>
> Missing qemu_opts_del(tcp_opts).
>

Will fix this!

>> @@ -5114,6 +5147,7 @@ echo "tcmalloc support  $tcmalloc"
>>  echo "jemalloc support  $jemalloc"
>>  echo "avx2 optimization $avx2_opt"
>>  echo "replication support $replication"
>> +echo "VxHS block device $vxhs"
>>
>>  if test "$sdl_too_old" = "yes"; then
>>  echo "-> Your SDL version is too old - please upgrade to have SDL support"
>> @@ -5729,6 +5763,12 @@ if test "$pthread_setname_np" = "yes" ; then
>>    echo "CONFIG_PTHREAD_SETNAME_NP=y" >> $config_host_mak
>>  fi
>>
>> +if test "$vxhs" = "yes" ; then
>> +  echo "CONFIG_VXHS=y" >> $config_host_mak
>> +  echo "VXHS_CFLAGS=$vxhs_cflags" >> $config_host_mak
>
> Please drop this unused variable.

Will fix this!


Thanks,
Ashish
