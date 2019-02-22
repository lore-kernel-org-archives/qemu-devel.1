Received: from eggs.gnu.org ([209.51.188.92]:48719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwyo1-0007ru-40
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 19:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwynx-0002C3-Ql
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 19:35:09 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwynx-0001s4-Et
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 19:35:05 -0500
Received: by mail-wm1-f47.google.com with SMTP id m1so401774wml.2
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 16:34:16 -0800 (PST)
References: <20190215155709.15777-1-berrange@redhat.com>
	<20190215155709.15777-11-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <81a05e66-016c-db53-c3f5-2607bb8c515e@redhat.com>
Date: Fri, 22 Feb 2019 01:34:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190215155709.15777-11-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 10/11] authz: add QAuthZPAM object type
 for authorizing using PAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Hi Daniel,

On 2/15/19 4:57 PM, Daniel P. Berrangé wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
> 
> Add an authorization backend that talks to PAM to check whether the user
> identity is allowed. This only uses the PAM account validation facility,
> which is essentially just a check to see if the provided username is permitted
> access. It doesn't use the authentication or session parts of PAM, since
> that's dealt with by the relevant part of QEMU (eg VNC server).
> 
> Consider starting QEMU with a VNC server and telling it to use TLS with
> x509 client certificates and configuring it to use an PAM to validate
> the x509 distinguished name. In this example we're telling it to use PAM
> for the QAuthZ impl with a service name of "qemu-vnc"
> 
>  $ qemu-system-x86_64 \
>      -object tls-creds-x509,id=tls0,dir=/home/berrange/security/qemutls,\
>              endpoint=server,verify-peer=yes \
>      -object authz-pam,id=authz0,service=qemu-vnc \
>      -vnc :1,tls-creds=tls0,tls-authz=authz0
> 
> This requires an /etc/pam/qemu-vnc file to be created with the auth
> rules. A very simple file based whitelist can be setup using
> 
>   $ cat > /etc/pam/qemu-vnc <<EOF
>   account         requisite       pam_listfile.so item=user sense=allow file=/etc/qemu/vnc.allow
>   EOF
> 
> The /etc/qemu/vnc.allow file simply contains one username per line. Any
> username not in the file is denied. The usernames in this example are
> the x509 distinguished name from the client's x509 cert.
> 
>   $ cat > /etc/qemu/vnc.allow <<EOF
>   CN=laptop.berrange.com,O=Berrange Home,L=London,ST=London,C=GB
>   EOF
> 
> More interesting would be to configure PAM to use an LDAP backend, so
> that the QEMU authorization check data can be centralized instead of
> requiring each compute host to have file maintained.
> 
> The main limitation with this PAM module is that the rules apply to all
> QEMU instances on the host. Setting up different rules per VM, would
> require creating a separate PAM service name & config file for every
> guest. An alternative approach for the future might be to not pass in
> the plain username to PAM, but instead combine the VM name or UUID with
> the username. This requires further consideration though.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  authz/Makefile.objs     |   3 +
>  authz/pamacct.c         | 149 ++++++++++++++++++++++++++++++++++++++++
>  authz/trace-events      |   3 +
>  configure               |  37 ++++++++++
>  include/authz/pamacct.h | 100 +++++++++++++++++++++++++++
>  qemu-options.hx         |  35 ++++++++++
>  tests/Makefile.include  |   2 +
>  tests/test-authz-pam.c  | 124 +++++++++++++++++++++++++++++++++
>  8 files changed, 453 insertions(+)
>  create mode 100644 authz/pamacct.c
>  create mode 100644 include/authz/pamacct.h
>  create mode 100644 tests/test-authz-pam.c
> 
> diff --git a/authz/Makefile.objs b/authz/Makefile.objs
> index 8351bf181d..ed7b273596 100644
> --- a/authz/Makefile.objs
> +++ b/authz/Makefile.objs
> @@ -2,3 +2,6 @@ authz-obj-y += base.o
>  authz-obj-y += simple.o
>  authz-obj-y += list.o
>  authz-obj-y += listfile.o
> +authz-obj-$(CONFIG_AUTH_PAM) += pamacct.o
> +
> +pamacct.o-libs = -lpam
> diff --git a/authz/pamacct.c b/authz/pamacct.c
> new file mode 100644
> index 0000000000..8fe4c8ee11
> --- /dev/null
> +++ b/authz/pamacct.c
> @@ -0,0 +1,149 @@
> +/*
> + * QEMU PAM authorization driver
> + *
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "authz/pamacct.h"
> +#include "authz/trace.h"
> +#include "qom/object_interfaces.h"
> +
> +#include <security/pam_appl.h>
> +
> +
> +static bool qauthz_pam_is_allowed(QAuthZ *authz,
> +                                  const char *identity,
> +                                  Error **errp)
> +{
> +    QAuthZPAM *pauthz = QAUTHZ_PAM(authz);
> +    const struct pam_conv pam_conversation = { 0 };
> +    pam_handle_t *pamh = NULL;
> +    int ret;
> +
> +    trace_qauthz_pam_check(authz, identity, pauthz->service);
> +    ret = pam_start(pauthz->service,
> +                    identity,
> +                    &pam_conversation,
> +                    &pamh);
> +    if (ret != PAM_SUCCESS) {
> +        error_setg(errp, "Unable to start PAM transaction: %s",
> +                   pam_strerror(NULL, ret));
> +        return false;
> +    }
> +
> +    ret = pam_acct_mgmt(pamh, PAM_SILENT);
> +    if (ret != PAM_SUCCESS) {
> +        error_setg(errp, "Unable to authorize user '%s': %s",
> +                   identity, pam_strerror(pamh, ret));
> +        goto cleanup;
> +    }
> +
> + cleanup:
> +    pam_end(pamh, ret);
> +    return ret == PAM_SUCCESS;
> +}

I still need to digest this function (reading more about PAM).

Code below reviewed/tested.

> +
> +
> +static void
> +qauthz_pam_prop_set_service(Object *obj,
> +                            const char *service,
> +                            Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZPAM *pauthz = QAUTHZ_PAM(obj);
> +
> +    g_free(pauthz->service);
> +    pauthz->service = g_strdup(service);
> +}
> +
> +
> +static char *
> +qauthz_pam_prop_get_service(Object *obj,
> +                            Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZPAM *pauthz = QAUTHZ_PAM(obj);
> +
> +    return g_strdup(pauthz->service);
> +}
> +
> +
> +static void
> +qauthz_pam_complete(UserCreatable *uc, Error **errp)
> +{
> +}
> +
> +
> +static void
> +qauthz_pam_finalize(Object *obj)
> +{
> +    QAuthZPAM *pauthz = QAUTHZ_PAM(obj);
> +
> +    g_free(pauthz->service);
> +}
> +
> +
> +static void
> +qauthz_pam_class_init(ObjectClass *oc, void *data)
> +{
> +    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
> +    QAuthZClass *authz = QAUTHZ_CLASS(oc);
> +
> +    ucc->complete = qauthz_pam_complete;
> +    authz->is_allowed = qauthz_pam_is_allowed;
> +
> +    object_class_property_add_str(oc, "service",
> +                                  qauthz_pam_prop_get_service,
> +                                  qauthz_pam_prop_set_service,
> +                                  NULL);
> +}
> +
> +
> +QAuthZPAM *qauthz_pam_new(const char *id,
> +                          const char *service,
> +                          Error **errp)
> +{
> +    return QAUTHZ_PAM(
> +        object_new_with_props(TYPE_QAUTHZ_PAM,
> +                              object_get_objects_root(),
> +                              id, errp,
> +                              "service", service,
> +                              NULL));
> +}
> +
> +
> +static const TypeInfo qauthz_pam_info = {
> +    .parent = TYPE_QAUTHZ,
> +    .name = TYPE_QAUTHZ_PAM,
> +    .instance_size = sizeof(QAuthZPAM),
> +    .instance_finalize = qauthz_pam_finalize,
> +    .class_size = sizeof(QAuthZPAMClass),
> +    .class_init = qauthz_pam_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +
> +static void
> +qauthz_pam_register_types(void)
> +{
> +    type_register_static(&qauthz_pam_info);
> +}
> +
> +
> +type_init(qauthz_pam_register_types);
> diff --git a/authz/trace-events b/authz/trace-events
> index fb65349a90..72c411927d 100644
> --- a/authz/trace-events
> +++ b/authz/trace-events
> @@ -13,3 +13,6 @@ qauthz_list_default_policy(void *authz, const char *identity, int policy) "AuthZ
>  # auth/listfile.c
>  qauthz_list_file_load(void *authz, const char *filename) "AuthZ file %p load filename=%s"
>  qauthz_list_file_refresh(void *authz, const char *filename, int success) "AuthZ file %p load filename=%s success=%d"
> +
> +# auth/pam.c
> +qauthz_pam_check(void *authz, const char *identity, const char *service) "AuthZ PAM %p identity=%s service=%s"
> diff --git a/configure b/configure
> index a61682c3c7..4fe916e31f 100755
> --- a/configure
> +++ b/configure
> @@ -463,6 +463,7 @@ gnutls=""
>  nettle=""
>  gcrypt=""
>  gcrypt_hmac="no"
> +auth_pam=""
>  vte=""
>  virglrenderer=""
>  tpm="yes"
> @@ -1381,6 +1382,10 @@ for opt do
>    ;;
>    --enable-gcrypt) gcrypt="yes"
>    ;;
> +  --disable-auth-pam) auth_pam="no"
> +  ;;
> +  --enable-auth-pam) auth_pam="yes"
> +  ;;
>    --enable-rdma) rdma="yes"
>    ;;
>    --disable-rdma) rdma="no"
> @@ -1707,6 +1712,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    gnutls          GNUTLS cryptography support
>    nettle          nettle cryptography support
>    gcrypt          libgcrypt cryptography support
> +  auth-pam        PAM access control
>    sdl             SDL UI
>    sdl_image       SDL Image support for icons
>    gtk             gtk UI
> @@ -2864,6 +2870,33 @@ else
>  fi
>  
>  
> +##########################################
> +# PAM probe
> +
> +if test "x$auth_pam" != "no"; then

Either check "x$auth_pam" != "xno", or "$auth_pam" != "no" (the latter
seems to follow the style of this file).

Currently this condition is always true, so the script always calls
compile_prog. And if an user has PAM locally installed, it is not
possible to not use it.

> +    cat > $TMPC <<EOF
> +#include <security/pam_appl.h>
> +#include <stdio.h>
> +int main(void) {
> +   const char *service_name = "qemu";
> +   const char *user = "frank";
> +   const struct pam_conv *pam_conv = NULL;
> +   pam_handle_t *pamh = NULL;
> +   pam_start(service_name, user, pam_conv, &pamh);
> +   return 0;
> +}
> +EOF
> +    if compile_prog "" "-lpam" ; then
> +	auth_pam=yes
> +    else
> +	if test "$auth_pam" = "yes"; then
> +	    feature_not_found "PAM" "Install PAM development package"
> +	else
> +	    auth_pam=no
> +	fi
> +    fi
> +fi
> +
>  ##########################################
>  # getifaddrs (for tests/test-io-channel-socket )
>  
> @@ -6083,6 +6116,7 @@ echo "GNUTLS support    $gnutls"
>  echo "libgcrypt         $gcrypt"
>  echo "nettle            $nettle $(echo_version $nettle $nettle_version)"
>  echo "libtasn1          $tasn1"
> +echo "PAM               $auth_pam"
>  echo "curses support    $curses"
>  echo "virgl support     $virglrenderer $(echo_version $virglrenderer $virgl_version)"
>  echo "curl support      $curl"
> @@ -6537,6 +6571,9 @@ fi
>  if test "$tasn1" = "yes" ; then
>    echo "CONFIG_TASN1=y" >> $config_host_mak
>  fi
> +if test "$auth_pam" = "yes" ; then
> +    echo "CONFIG_AUTH_PAM=y" >> $config_host_mak
> +fi
>  if test "$have_ifaddrs_h" = "yes" ; then
>      echo "HAVE_IFADDRS_H=y" >> $config_host_mak
>  fi
> diff --git a/include/authz/pamacct.h b/include/authz/pamacct.h
> new file mode 100644
> index 0000000000..6e3046e528
> --- /dev/null
> +++ b/include/authz/pamacct.h
> @@ -0,0 +1,100 @@
> +/*
> + * QEMU PAM authorization driver
> + *
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#ifndef QAUTHZ_PAM_H__
> +#define QAUTHZ_PAM_H__
> +
> +#include "authz/base.h"
> +
> +
> +#define TYPE_QAUTHZ_PAM "authz-pam"
> +
> +#define QAUTHZ_PAM_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(QAuthZPAMClass, (klass), \
> +                        TYPE_QAUTHZ_PAM)
> +#define QAUTHZ_PAM_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(QAuthZPAMClass, (obj), \
> +                      TYPE_QAUTHZ_PAM)
> +#define QAUTHZ_PAM(obj) \
> +     INTERFACE_CHECK(QAuthZPAM, (obj), \
> +                     TYPE_QAUTHZ_PAM)
> +
> +typedef struct QAuthZPAM QAuthZPAM;
> +typedef struct QAuthZPAMClass QAuthZPAMClass;
> +
> +
> +/**
> + * QAuthZPAM:
> + *
> + * This authorization driver provides a PAM mechanism
> + * for granting access by matching user names against a
> + * list of globs. Each match rule has an associated policy
> + * and a catch all policy applies if no rule matches
> + *
> + * To create an instance of this class via QMP:
> + *
> + *  {
> + *    "execute": "object-add",
> + *    "arguments": {
> + *      "qom-type": "authz-pam",
> + *      "id": "authz0",
> + *      "parameters": {
> + *        "service": "qemu-vnc-tls"
> + *      }
> + *    }
> + *  }
> + *
> + * The driver only uses the PAM "account" verification
> + * subsystem. The above config would require a config
> + * file /etc/pam.d/qemu-vnc-tls. For a simple file
> + * lookup it would contain
> + *
> + *   account requisite  pam_listfile.so item=user sense=allow \
> + *           file=/etc/qemu/vnc.allow
> + *
> + * The external file would then contain a list of usernames.
> + * If x509 cert was being used as the username, a suitable
> + * entry would match the distinguish name:
> + *
> + *  CN=laptop.berrange.com,O=Berrange Home,L=London,ST=London,C=GB
> + *
> + * On the command line it can be created using
> + *
> + *   -object authz-pam,id=authz0,service=qemu-vnc-tls
> + *
> + */
> +struct QAuthZPAM {
> +    QAuthZ parent_obj;
> +
> +    char *service;
> +};
> +
> +
> +struct QAuthZPAMClass {
> +    QAuthZClass parent_class;
> +};
> +
> +
> +QAuthZPAM *qauthz_pam_new(const char *id,
> +                          const char *service,
> +                          Error **errp);
> +
> +
> +#endif /* QAUTHZ_PAM_H__ */
> diff --git a/qemu-options.hx b/qemu-options.hx
> index e34d30a013..22cfb32489 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4430,6 +4430,41 @@ would look like:
>       ...
>  @end example
>  
> +@item -object authz-pam,id=@var{id},service=@var{string}
> +
> +Create an authorization object that will control access to network services.
> +
> +The @option{service} parameter provides the name of a PAM service to use
> +for authorization. It requires that a file @code{/etc/pam.d/@var{service}}
> +exist to provide the configuration for the @code{account} subsystem.
> +
> +An example authorization object to validate a TLS x509 distinguished
> +name would look like:
> +
> +@example
> + # $QEMU \
> +     ...
> +     -object authz-pam,id=auth0,service=qemu-vnc
> +     ...
> +@end example
> +
> +There would then be a corresponding config file for PAM at
> +@code{/etc/pam.d/qemu-vnc} that contains:
> +
> +@example
> +account requisite  pam_listfile.so item=user sense=allow \
> +           file=/etc/qemu/vnc.allow
> +@end example
> +
> +Finally the @code{/etc/qemu/vnc.allow} file would contain
> +the list of x509 distingished names that are permitted
> +access
> +
> +@example
> +CN=laptop.example.com,O=Example Home,L=London,ST=London,C=GB
> +@end example
> +
> +
>  @end table
>  
>  ETEXI
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 199e74d670..bc11d565a6 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -119,6 +119,7 @@ check-unit-y += tests/test-util-sockets$(EXESUF)
>  check-unit-y += tests/test-authz-simple$(EXESUF)
>  check-unit-y += tests/test-authz-list$(EXESUF)
>  check-unit-y += tests/test-authz-listfile$(EXESUF)
> +check-unit-$(CONFIG_AUTH_PAM) += tests/test-authz-pam$(EXESUF)
>  check-unit-y += tests/test-io-task$(EXESUF)
>  check-unit-y += tests/test-io-channel-socket$(EXESUF)
>  check-unit-y += tests/test-io-channel-file$(EXESUF)
> @@ -669,6 +670,7 @@ tests/test-util-sockets$(EXESUF): tests/test-util-sockets.o \
>  tests/test-authz-simple$(EXESUF): tests/test-authz-simple.o $(test-authz-obj-y)
>  tests/test-authz-list$(EXESUF): tests/test-authz-list.o $(test-authz-obj-y)
>  tests/test-authz-listfile$(EXESUF): tests/test-authz-listfile.o $(test-authz-obj-y)
> +tests/test-authz-pam$(EXESUF): tests/test-authz-pam.o $(test-authz-obj-y)
>  tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
>  tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
>          tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-y)
> diff --git a/tests/test-authz-pam.c b/tests/test-authz-pam.c
> new file mode 100644
> index 0000000000..93d5ac8bbf
> --- /dev/null
> +++ b/tests/test-authz-pam.c
> @@ -0,0 +1,124 @@
> +/*
> + * QEMU PAM authorization object tests
> + *
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "authz/pamacct.h"
> +
> +#include <security/pam_appl.h>
> +
> +static bool failauth;
> +
> +/*
> + * These two functions are exported by libpam.so.
> + *
> + * By defining them again here, our impls are resolved
> + * by the linker instead of those in libpam.so
> + *
> + * The test suite is thus isolated from the host system
> + * PAM setup, so we can do predictable test scenarios
> + */
> +int
> +pam_start(const char *service_name, const char *user,
> +          const struct pam_conv *pam_conversation,
> +          pam_handle_t **pamh)
> +{
> +    failauth = true;
> +    if (!g_str_equal(service_name, "qemu-vnc")) {
> +        return PAM_AUTH_ERR;
> +    }
> +
> +    if (g_str_equal(user, "fred")) {
> +        failauth = false;
> +    }
> +
> +    return PAM_SUCCESS;
> +}
> +
> +
> +int
> +pam_acct_mgmt(pam_handle_t *pamh, int flags)
> +{
> +    if (failauth) {
> +        return PAM_AUTH_ERR;
> +    }
> +
> +    return PAM_SUCCESS;
> +}
> +
> +
> +static void test_authz_unknown_service(void)
> +{
> +    Error *local_err = NULL;
> +    QAuthZPAM *auth = qauthz_pam_new("auth0",
> +                                     "qemu-does-not-exist",
> +                                     &error_abort);
> +
> +    g_assert_nonnull(auth);
> +
> +    g_assert_false(qauthz_is_allowed(QAUTHZ(auth), "fred", &local_err));
> +
> +    error_free_or_abort(&local_err);
> +    object_unparent(OBJECT(auth));
> +}
> +
> +
> +static void test_authz_good_user(void)
> +{
> +    QAuthZPAM *auth = qauthz_pam_new("auth0",
> +                                     "qemu-vnc",
> +                                     &error_abort);
> +
> +    g_assert_nonnull(auth);
> +
> +    g_assert_true(qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
> +
> +    object_unparent(OBJECT(auth));
> +}
> +
> +
> +static void test_authz_bad_user(void)
> +{
> +    Error *local_err = NULL;
> +    QAuthZPAM *auth = qauthz_pam_new("auth0",
> +                                     "qemu-vnc",
> +                                     &error_abort);
> +
> +    g_assert_nonnull(auth);
> +
> +    g_assert_false(qauthz_is_allowed(QAUTHZ(auth), "bob", &local_err));
> +
> +    error_free_or_abort(&local_err);
> +    object_unparent(OBJECT(auth));
> +}
> +
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    module_call_init(MODULE_INIT_QOM);
> +
> +    g_test_add_func("/auth/pam/unknown-service", test_authz_unknown_service);
> +    g_test_add_func("/auth/pam/good-user", test_authz_good_user);
> +    g_test_add_func("/auth/pam/bad-user", test_authz_bad_user);
> +
> +    return g_test_run();
> +}
> 

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
