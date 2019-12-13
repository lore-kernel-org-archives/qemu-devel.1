Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F20C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD08820706
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jtn8y4db"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD08820706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifo3f-0006aR-JV
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:44:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifnry-0000oh-QV
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifnru-0006QI-IJ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:32:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21453
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifnru-0006OB-Bw
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576254761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pEpFuao6UiE29OHzvmNIgde2j3vtFN8e5aLr9IcEERk=;
 b=Jtn8y4dbMH3Mzt3mhPyWSuc9ynN58oRTCo6a5geq0CjrjPn7G9U0++y54iBaXvD5CY3+T7
 RLkIUE6qWt5vpHL+tTH342VgiZ/fpMrhQVdSUsUEmw5nly6yBouH/uzIu2EesMjyC2YetT
 sfz7U90ieN3IYdJdiKhwX7+H0W7foYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-zNZeC5CWNNCPrNDVyIKVYQ-1; Fri, 13 Dec 2019 11:32:38 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1586A107ACCD
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 16:32:37 +0000 (UTC)
Received: from work-vm (unknown [10.36.117.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64C445195A;
 Fri, 13 Dec 2019 16:32:32 +0000 (UTC)
Date: Fri, 13 Dec 2019 16:32:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v6 5/8] Add dbus-vmstate object
Message-ID: <20191213163230.GL3713@work-vm>
References: <20191211134506.1803403-1-marcandre.lureau@redhat.com>
 <20191211134506.1803403-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191211134506.1803403-6-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: zNZeC5CWNNCPrNDVyIKVYQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: mprivozn@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:

<snip>

Generally from the migration side I'm OK; I don't know that
much glib stuff as you're using, so I'll leave that to Dan.

> +    if (!result) {
> +        error_report("Failed to Load: %s", err->message);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int dbus_vmstate_post_load(void *opaque, int version_id)
> +{
> +    DBusVMState *self =3D DBUS_VMSTATE(opaque);
> +    g_autoptr(GInputStream) m =3D NULL;
> +    g_autoptr(GDataInputStream) s =3D NULL;
> +    g_autoptr(GError) err =3D NULL;
> +    g_autoptr(GHashTable) proxies =3D NULL;
> +    uint32_t nelem;
> +
> +    proxies =3D dbus_get_proxies(self, &err);
> +    if (!proxies) {
> +        error_report("Failed to get proxies: %s", err->message);

Generally can you put either the function name or something in the error
to point us in the right direction; then if a user gets an error and it
says dbus_vmstate_post_load: Failed to get proxies   (e.g. by using %s:
...__func__)  then any random qemu dev will be able to resolve the blame
pointer quickly and not trying to guess which proxies we're talking
about.

You might also like to add some trace_ calls to watch what is going on.

Dave

> +        return -1;
> +    }
> +
> +    m =3D g_memory_input_stream_new_from_data(self->data, self->data_siz=
e, NULL);
> +    s =3D g_data_input_stream_new(m);
> +    g_data_input_stream_set_byte_order(s, G_DATA_STREAM_BYTE_ORDER_BIG_E=
NDIAN);
> +
> +    nelem =3D g_data_input_stream_read_uint32(s, NULL, &err);
> +    if (err) {
> +        goto error;
> +    }
> +
> +    while (nelem > 0) {
> +        GDBusProxy *proxy =3D NULL;
> +        uint32_t len;
> +        gsize bytes_read, avail;
> +        char id[256];
> +
> +        len =3D g_data_input_stream_read_uint32(s, NULL, &err);
> +        if (err) {
> +            goto error;
> +        }
> +        if (len >=3D 256) {
> +            error_report("Invalid DBus vmstate proxy name %u", len);
> +            return -1;
> +        }
> +        if (!g_input_stream_read_all(G_INPUT_STREAM(s), id, len,
> +                                     &bytes_read, NULL, &err)) {
> +            goto error;
> +        }
> +        g_return_val_if_fail(bytes_read =3D=3D len, -1);
> +        id[len] =3D 0;
> +
> +        proxy =3D g_hash_table_lookup(proxies, id);
> +        if (!proxy) {
> +            error_report("Failed to find proxy Id '%s'", id);
> +            return -1;
> +        }
> +
> +        len =3D g_data_input_stream_read_uint32(s, NULL, &err);
> +        avail =3D g_buffered_input_stream_get_available(
> +            G_BUFFERED_INPUT_STREAM(s));
> +
> +        if (len > DBUS_VMSTATE_SIZE_LIMIT || len > avail) {
> +            error_report("Invalid vmstate size: %u", len);
> +            return -1;
> +        }
> +
> +        if (dbus_load_state_proxy(proxy,
> +                g_buffered_input_stream_peek_buffer(G_BUFFERED_INPUT_STR=
EAM(s),
> +                                                    NULL),
> +                len) < 0) {
> +            error_report("Failed to restore Id '%s'", id);
> +            return -1;
> +        }
> +
> +        if (!g_seekable_seek(G_SEEKABLE(s), len, G_SEEK_CUR, NULL, &err)=
) {
> +            goto error;
> +        }
> +
> +        nelem -=3D 1;
> +    }
> +
> +    return 0;
> +
> +error:
> +    error_report("Failed to read from stream: %s", err->message);
> +    return -1;
> +}
> +
> +static void
> +dbus_save_state_proxy(gpointer key,
> +                      gpointer value,
> +                      gpointer user_data)
> +{
> +    GDataOutputStream *s =3D user_data;
> +    const char *id =3D key;
> +    GDBusProxy *proxy =3D value;
> +    g_autoptr(GVariant) result =3D NULL;
> +    g_autoptr(GVariant) child =3D NULL;
> +    g_autoptr(GError) err =3D NULL;
> +    const uint8_t *data;
> +    gsize size;
> +
> +    result =3D g_dbus_proxy_call_sync(proxy, "Save",
> +                                    NULL, G_DBUS_CALL_FLAGS_NO_AUTO_STAR=
T,
> +                                    -1, NULL, &err);
> +    if (!result) {
> +        error_report("Failed to Save: %s", err->message);
> +        return;
> +    }
> +
> +    child =3D g_variant_get_child_value(result, 0);
> +    data =3D g_variant_get_fixed_array(child, &size, sizeof(char));
> +    if (!data) {
> +        error_report("Failed to Save: not a byte array");
> +        return;
> +    }
> +    if (size > DBUS_VMSTATE_SIZE_LIMIT) {
> +        error_report("Too large vmstate data to save: %" G_GSIZE_FORMAT,=
 size);
> +        return;
> +    }
> +
> +    if (!g_data_output_stream_put_uint32(s, strlen(id), NULL, &err) ||
> +        !g_data_output_stream_put_string(s, id, NULL, &err) ||
> +        !g_data_output_stream_put_uint32(s, size, NULL, &err) ||
> +        !g_output_stream_write_all(G_OUTPUT_STREAM(s),
> +                                   data, size, NULL, NULL, &err)) {
> +        error_report("Failed to write to stream: %s", err->message);
> +    }
> +}
> +
> +static int dbus_vmstate_pre_save(void *opaque)
> +{
> +    DBusVMState *self =3D DBUS_VMSTATE(opaque);
> +    g_autoptr(GOutputStream) m =3D NULL;
> +    g_autoptr(GDataOutputStream) s =3D NULL;
> +    g_autoptr(GHashTable) proxies =3D NULL;
> +    g_autoptr(GError) err =3D NULL;
> +
> +    proxies =3D dbus_get_proxies(self, &err);
> +    if (!proxies) {
> +        error_report("Failed to get proxies: %s", err->message);
> +        return -1;
> +    }
> +
> +    m =3D g_memory_output_stream_new_resizable();
> +    s =3D g_data_output_stream_new(m);
> +    g_data_output_stream_set_byte_order(s, G_DATA_STREAM_BYTE_ORDER_BIG_=
ENDIAN);
> +
> +    if (!g_data_output_stream_put_uint32(s, g_hash_table_size(proxies),
> +                                         NULL, &err)) {
> +        error_report("Failed to write to stream: %s", err->message);
> +        return -1;
> +    }
> +
> +    g_hash_table_foreach(proxies, dbus_save_state_proxy, s);
> +
> +    if (g_memory_output_stream_get_size(G_MEMORY_OUTPUT_STREAM(m))
> +        > UINT32_MAX) {
> +        error_report("DBus vmstate buffer is too large");
> +        return -1;
> +    }
> +
> +    if (!g_output_stream_close(G_OUTPUT_STREAM(m), NULL, &err)) {
> +        error_report("Failed to close stream: %s", err->message);
> +        return -1;
> +    }
> +
> +    g_free(self->data);
> +    self->data_size =3D
> +        g_memory_output_stream_get_size(G_MEMORY_OUTPUT_STREAM(m));
> +    self->data =3D
> +        g_memory_output_stream_steal_data(G_MEMORY_OUTPUT_STREAM(m));
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription dbus_vmstate =3D {
> +    .name =3D TYPE_DBUS_VMSTATE,
> +    .version_id =3D 0,
> +    .pre_save =3D dbus_vmstate_pre_save,
> +    .post_load =3D dbus_vmstate_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(data_size, DBusVMState),
> +        VMSTATE_VBUFFER_ALLOC_UINT32(data, DBusVMState, 0, 0, data_size)=
,
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void
> +dbus_vmstate_complete(UserCreatable *uc, Error **errp)
> +{
> +    DBusVMState *self =3D DBUS_VMSTATE(uc);
> +    GError *err =3D NULL;
> +    GDBusConnection *bus;
> +
> +    if (!object_resolve_path_type("", TYPE_DBUS_VMSTATE, NULL)) {
> +        error_setg(errp, "There is already an instance of %s",
> +                   TYPE_DBUS_VMSTATE);
> +        return;
> +    }
> +
> +    if (!self->dbus_addr) {
> +        error_setg(errp, QERR_MISSING_PARAMETER, "addr");
> +        return;
> +    }
> +
> +    bus =3D g_dbus_connection_new_for_address_sync(self->dbus_addr,
> +             G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT |
> +             G_DBUS_CONNECTION_FLAGS_MESSAGE_BUS_CONNECTION,
> +             NULL, NULL, &err);
> +    if (err) {
> +        error_setg(errp, "failed to connect to DBus: '%s'", err->message=
);
> +        g_clear_error(&err);
> +    }
> +
> +    self->bus =3D bus;
> +
> +    if (vmstate_register(VMSTATE_IF(self), -1, &dbus_vmstate, self) < 0)=
 {
> +        error_setg(errp, "Failed to register vmstate");
> +    }
> +}
> +
> +static void
> +dbus_vmstate_finalize(Object *o)
> +{
> +    DBusVMState *self =3D DBUS_VMSTATE(o);
> +
> +    vmstate_unregister(VMSTATE_IF(self), &dbus_vmstate, self);
> +
> +    g_clear_object(&self->bus);
> +    g_free(self->dbus_addr);
> +    g_free(self->id_list);
> +    g_free(self->data);
> +}
> +
> +static char *
> +get_dbus_addr(Object *o, Error **errp)
> +{
> +    DBusVMState *self =3D DBUS_VMSTATE(o);
> +
> +    return g_strdup(self->dbus_addr);
> +}
> +
> +static void
> +set_dbus_addr(Object *o, const char *str, Error **errp)
> +{
> +    DBusVMState *self =3D DBUS_VMSTATE(o);
> +
> +    g_free(self->dbus_addr);
> +    self->dbus_addr =3D g_strdup(str);
> +}
> +
> +static char *
> +get_id_list(Object *o, Error **errp)
> +{
> +    DBusVMState *self =3D DBUS_VMSTATE(o);
> +
> +    return g_strdup(self->id_list);
> +}
> +
> +static void
> +set_id_list(Object *o, const char *str, Error **errp)
> +{
> +    DBusVMState *self =3D DBUS_VMSTATE(o);
> +
> +    g_free(self->id_list);
> +    self->id_list =3D g_strdup(str);
> +}
> +
> +static char *
> +dbus_vmstate_get_id(VMStateIf *vmif)
> +{
> +    return g_strdup(TYPE_DBUS_VMSTATE);
> +}
> +
> +static void
> +dbus_vmstate_class_init(ObjectClass *oc, void *data)
> +{
> +    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
> +    VMStateIfClass *vc =3D VMSTATE_IF_CLASS(oc);
> +
> +    ucc->complete =3D dbus_vmstate_complete;
> +    vc->get_id =3D dbus_vmstate_get_id;
> +
> +    object_class_property_add_str(oc, "addr",
> +                                  get_dbus_addr, set_dbus_addr,
> +                                  &error_abort);
> +    object_class_property_add_str(oc, "id-list",
> +                                  get_id_list, set_id_list,
> +                                  &error_abort);
> +}
> +
> +static const TypeInfo dbus_vmstate_info =3D {
> +    .name =3D TYPE_DBUS_VMSTATE,
> +    .parent =3D TYPE_OBJECT,
> +    .instance_size =3D sizeof(DBusVMState),
> +    .instance_finalize =3D dbus_vmstate_finalize,
> +    .class_size =3D sizeof(DBusVMStateClass),
> +    .class_init =3D dbus_vmstate_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { TYPE_VMSTATE_IF },
> +        { }
> +    }
> +};
> +
> +static void
> +register_types(void)
> +{
> +    type_register_static(&dbus_vmstate_info);
> +}
> +
> +type_init(register_types);
> diff --git a/docs/interop/dbus-vmstate.rst b/docs/interop/dbus-vmstate.rs=
t
> new file mode 100644
> index 0000000000..8693891640
> --- /dev/null
> +++ b/docs/interop/dbus-vmstate.rst
> @@ -0,0 +1,74 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +D-Bus VMState
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The QEMU dbus-vmstate object's aim is to migrate helpers' data running
> +on a QEMU D-Bus bus. (refer to the :doc:`dbus` document for
> +recommendation on D-Bus usage)
> +
> +Upon migration, QEMU will go through the queue of
> +``org.qemu.VMState1`` D-Bus name owners and query their ``Id``. It
> +must be unique among the helpers.
> +
> +It will then save arbitrary data of each Id to be transferred in the
> +migration stream and restored/loaded at the corresponding destination
> +helper.
> +
> +The data amount to be transferred is limited to 1Mb. The state must be
> +saved quickly (a few seconds maximum). (D-Bus imposes a time limit on
> +reply anyway, and migration would fail if data isn't given quickly
> +enough.)
> +
> +dbus-vmstate object can be configured with the expected list of
> +helpers by setting its ``id-list`` property, with a comma-separated
> +``Id`` list.
> +
> +Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +On object path ``/org/qemu/VMState1``, the following
> +``org.qemu.VMState1`` interface should be implemented:
> +
> +.. code:: xml
> +
> +  <interface name=3D"org.qemu.VMState1">
> +    <property name=3D"Id" type=3D"s" access=3D"read"/>
> +    <method name=3D"Load">
> +      <arg type=3D"ay" name=3D"data" direction=3D"in"/>
> +    </method>
> +    <method name=3D"Save">
> +      <arg type=3D"ay" name=3D"data" direction=3D"out"/>
> +    </method>
> +  </interface>
> +
> +"Id" property
> +-------------
> +
> +A string that identifies the helper uniquely. (maximum 256 bytes
> +including terminating NUL byte)
> +
> +.. note::
> +
> +   The helper ID namespace is a separate namespace. In particular, it is=
 not
> +   related to QEMU "id" used in -object/-device objects.
> +
> +Load(in u8[] bytes) method
> +--------------------------
> +
> +The method called on destination with the state to restore.
> +
> +The helper may be initially started in a waiting state (with
> +an --incoming argument for example), and it may resume on success.
> +
> +An error may be returned to the caller.
> +
> +Save(out u8[] bytes) method
> +---------------------------
> +
> +The method called on the source to get the current state to be
> +migrated. The helper should continue to run normally.
> +
> +An error may be returned to the caller.
> diff --git a/docs/interop/dbus.rst b/docs/interop/dbus.rst
> index 3d760e4882..d9af608dc9 100644
> --- a/docs/interop/dbus.rst
> +++ b/docs/interop/dbus.rst
> @@ -97,3 +97,8 @@ the "D-Bus API Design Guidelines":
>  https://dbus.freedesktop.org/doc/dbus-api-design.html
> =20
>  The "org.qemu.*" prefix is reserved for the QEMU project.
> +
> +QEMU Interfaces
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:doc:`dbus-vmstate`
> diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> index ded134ea75..049387ac6d 100644
> --- a/docs/interop/index.rst
> +++ b/docs/interop/index.rst
> @@ -14,6 +14,7 @@ Contents:
> =20
>     bitmaps
>     dbus
> +   dbus-vmstate
>     live-block-operations
>     pr-helper
>     qemu-ga
> --=20
> 2.24.0.308.g228f53135a
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


